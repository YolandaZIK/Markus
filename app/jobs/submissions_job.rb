class SubmissionsJob < ApplicationJob

  queue_as MarkusConfigurator.markus_job_collect_submissions_queue_name

  def self.on_complete_js(status)
    'window.submissionTable.wrapped.fetchData'
  end

  def self.show_status(status)
    I18n.t('poll_job.submissions_job', progress: status[:progress],
           total: status[:total])
  end

  before_enqueue do |job|
    status.update(job_class: self.class)
  end

  def perform(groupings, options = {})
    return if groupings.empty?

    m_logger = MarkusLogger.instance
    assignment = groupings.first.assignment
    time = assignment.submission_rule.calculate_collection_time.localtime

    progress.total = groupings.size
    groupings.each do |grouping|
      begin
        m_logger.log("Now collecting: #{assignment.short_identifier} for grouping: " +
                     "#{grouping.id}")
        if options[:revision_identifier].nil?
          new_submission = Submission.create_by_timestamp(grouping, time)
        else
          new_submission = Submission.create_by_revision_identifier(grouping, options[:revision_identifier])
        end

        if assignment.submission_rule.is_a? GracePeriodSubmissionRule
          # Return any grace credits previously deducted for this grouping.
          assignment.submission_rule.remove_deductions(grouping)
        end

        if options[:apply_late_penalty].nil? || options[:apply_late_penalty]
          new_submission = assignment.submission_rule.apply_submission_rule(
            new_submission)
        end

        grouping.is_collected = true
        grouping.save
      rescue => e
        Rails.logger.error e.message
      ensure
        progress.increment
      end
    end
    m_logger.log('Submission collection process done')
  end
end
