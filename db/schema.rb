# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160509144712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotation_categories", force: :cascade do |t|
    t.text     "annotation_category_name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignment_id",            null: false
  end

  add_index "annotation_categories", ["assignment_id"], name: "index_annotation_categories_on_assignment_id", using: :btree

  create_table "annotation_texts", force: :cascade do |t|
    t.text     "content"
    t.integer  "annotation_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "last_editor_id"
  end

  add_index "annotation_texts", ["annotation_category_id"], name: "index_annotation_texts_on_annotation_category_id", using: :btree

  create_table "annotations", force: :cascade do |t|
    t.integer "line_start"
    t.integer "line_end"
    t.integer "annotation_text_id"
    t.integer "submission_file_id"
    t.integer "x1"
    t.integer "x2"
    t.integer "y1"
    t.integer "y2"
    t.string  "type"
    t.integer "annotation_number"
    t.boolean "is_remark"
    t.integer "page"
    t.integer "column_start"
    t.integer "column_end"
    t.integer "creator_id"
    t.string  "creator_type"
    t.integer "result_id"
  end

  add_index "annotations", ["creator_type", "creator_id"], name: "index_annotations_on_creator_type_and_creator_id", using: :btree
  add_index "annotations", ["submission_file_id"], name: "index_annotations_on_submission_file_id", using: :btree

  create_table "assignment_files", force: :cascade do |t|
    t.integer  "assignment_id"
    t.string   "filename",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignment_files", ["assignment_id", "filename"], name: "index_assignment_files_on_assignment_id_and_filename", unique: true, using: :btree
  add_index "assignment_files", ["assignment_id"], name: "index_assignment_files_on_assignment_id", using: :btree

  create_table "assignment_stats", force: :cascade do |t|
    t.integer "assignment_id"
    t.text    "grade_distribution_percentage"
  end

  create_table "assignments", force: :cascade do |t|
    t.string   "short_identifier",                                    null: false
    t.string   "description"
    t.text     "message"
    t.datetime "due_date"
    t.integer  "group_min",                        default: 1,        null: false
    t.integer  "group_max",                        default: 1,        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "student_form_groups"
    t.boolean  "group_name_autogenerated"
    t.boolean  "group_name_displayed"
    t.string   "repository_folder",                                   null: false
    t.boolean  "invalid_override"
    t.float    "results_average"
    t.string   "marking_scheme_type",              default: "rubric"
    t.boolean  "allow_web_submits",                default: true
    t.boolean  "section_groups_only"
    t.boolean  "section_due_dates_type",           default: false
    t.boolean  "display_grader_names_to_students", default: false
    t.boolean  "enable_test",                      default: false,    null: false
    t.integer  "notes_count",                      default: 0
    t.boolean  "assign_graders_to_criteria",       default: false
    t.integer  "rubric_criterions_count"
    t.integer  "flexible_criterions_count"
    t.integer  "groupings_count"
    t.integer  "tokens_per_day",                   default: 0,        null: false
    t.boolean  "allow_remarks",                    default: true,     null: false
    t.datetime "remark_due_date"
    t.text     "remark_message"
    t.float    "results_median"
    t.integer  "results_fails"
    t.integer  "results_zeros"
    t.integer  "outstanding_remark_request_count"
    t.boolean  "is_hidden",                        default: false
    t.boolean  "only_required_files"
    t.boolean  "vcs_submit",                       default: false
  end

  add_index "assignments", ["short_identifier"], name: "index_assignments_on_short_identifier", unique: true, using: :btree

  create_table "criterion_ta_associations", force: :cascade do |t|
    t.integer  "ta_id"
    t.integer  "criterion_id"
    t.string   "criterion_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignment_id"
  end

  add_index "criterion_ta_associations", ["criterion_id"], name: "index_criterion_ta_associations_on_criterion_id", using: :btree
  add_index "criterion_ta_associations", ["ta_id"], name: "index_criterion_ta_associations_on_ta_id", using: :btree

  create_table "extra_marks", force: :cascade do |t|
    t.integer  "result_id"
    t.string   "description"
    t.float    "extra_mark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unit"
  end

  add_index "extra_marks", ["result_id"], name: "index_extra_marks_on_result_id", using: :btree

  create_table "flexible_criteria", force: :cascade do |t|
    t.string   "name",                                                       null: false
    t.text     "description"
    t.integer  "position"
    t.integer  "assignment_id",                                              null: false
    t.decimal  "max",                   precision: 10, scale: 1,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assigned_groups_count",                          default: 0
  end

  add_index "flexible_criteria", ["assignment_id", "name"], name: "index_flexible_criteria_on_assignment_id_and_name", unique: true, using: :btree
  add_index "flexible_criteria", ["assignment_id"], name: "index_flexible_criteria_on_assignment_id", using: :btree

  create_table "grace_period_deductions", force: :cascade do |t|
    t.integer  "membership_id"
    t.integer  "deduction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grace_period_deductions", ["membership_id"], name: "index_grace_period_deductions_on_membership_id", using: :btree

  create_table "grade_entry_forms", force: :cascade do |t|
    t.string   "short_identifier", null: false
    t.string   "description"
    t.text     "message"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_total"
    t.boolean  "is_hidden"
  end

  add_index "grade_entry_forms", ["short_identifier"], name: "index_grade_entry_forms_on_short_identifier", unique: true, using: :btree

  create_table "grade_entry_items", force: :cascade do |t|
    t.integer  "grade_entry_form_id"
    t.string   "name",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "out_of"
    t.integer  "position"
    t.boolean  "bonus",               default: false
  end

  add_index "grade_entry_items", ["grade_entry_form_id", "name"], name: "index_grade_entry_items_on_grade_entry_form_id_and_name", unique: true, using: :btree

  create_table "grade_entry_students", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "grade_entry_form_id"
    t.boolean  "released_to_student"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_grade"
  end

  add_index "grade_entry_students", ["user_id", "grade_entry_form_id"], name: "index_grade_entry_students_on_user_id_and_grade_entry_form_id", unique: true, using: :btree

  create_table "grade_entry_students_tas", force: :cascade do |t|
    t.integer "grade_entry_student_id"
    t.integer "ta_id"
  end

  create_table "grades", force: :cascade do |t|
    t.integer  "grade_entry_item_id"
    t.integer  "grade_entry_student_id"
    t.float    "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grades", ["grade_entry_item_id", "grade_entry_student_id"], name: "index_grades_on_grade_entry_item_id_and_grade_entry_student_id", unique: true, using: :btree

  create_table "grouping_queues", force: :cascade do |t|
    t.integer "submission_collector_id"
    t.boolean "priority_queue",          default: false
  end

  create_table "groupings", force: :cascade do |t|
    t.integer  "group_id",                                null: false
    t.integer  "assignment_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin_approved",          default: false, null: false
    t.integer  "grouping_queue_id"
    t.boolean  "is_collected",            default: false
    t.integer  "notes_count",             default: 0
    t.integer  "criteria_coverage_count", default: 0
    t.boolean  "error_collecting",        default: false
  end

  add_index "groupings", ["assignment_id", "group_id"], name: "groupings_u1", unique: true, using: :btree

  create_table "groupings_tags", id: false, force: :cascade do |t|
    t.integer "tag_id",      null: false
    t.integer "grouping_id", null: false
  end

  add_index "groupings_tags", ["tag_id", "grouping_id"], name: "index_groupings_tags_on_tag_id_and_grouping_id", unique: true, using: :btree

  create_table "groups", force: :cascade do |t|
    t.string "group_name", limit: 30
    t.string "repo_name"
  end

  add_index "groups", ["group_name"], name: "groups_name_unique", unique: true, using: :btree

  create_table "job_messengers", force: :cascade do |t|
    t.string   "job_id"
    t.string   "status"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "job_messengers", ["job_id"], name: "index_job_messengers_on_job_id", using: :btree

  create_table "key_pairs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marking_schemes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marking_weights", force: :cascade do |t|
    t.integer  "marking_scheme_id"
    t.integer  "gradable_item_id"
    t.decimal  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_assignment",     null: false
  end

  create_table "marks", force: :cascade do |t|
    t.integer  "result_id"
    t.integer  "markable_id"
    t.float    "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "markable_type"
  end

  add_index "marks", ["markable_id", "result_id", "markable_type"], name: "marks_u1", unique: true, using: :btree
  add_index "marks", ["markable_id"], name: "index_marks_on_markable_id", using: :btree
  add_index "marks", ["result_id"], name: "index_marks_on_result_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "membership_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grouping_id",       null: false
    t.string   "type"
  end

  add_index "memberships", ["grouping_id", "user_id"], name: "memberships_u1", unique: true, using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "notes_message", null: false
    t.integer  "creator_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "noteable_id",   null: false
    t.string   "noteable_type", null: false
  end

  add_index "notes", ["creator_id"], name: "index_notes_on_creator_id", using: :btree

  create_table "periods", force: :cascade do |t|
    t.integer  "submission_rule_id"
    t.float    "deduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "hours"
    t.float    "interval"
    t.string   "submission_rule_type"
  end

  add_index "periods", ["submission_rule_id"], name: "index_periods_on_submission_rule_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.integer  "submission_id"
    t.string   "marking_state"
    t.text     "overall_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "released_to_students",        default: false, null: false
    t.float    "total_mark",                  default: 0.0
    t.datetime "remark_request_submitted_at"
  end

  create_table "rubric_criteria", force: :cascade do |t|
    t.string   "name",                              null: false
    t.integer  "assignment_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "level_0_name"
    t.text     "level_0_description"
    t.text     "level_1_name"
    t.text     "level_1_description"
    t.text     "level_2_name"
    t.text     "level_2_description"
    t.text     "level_3_name"
    t.text     "level_3_description"
    t.text     "level_4_name"
    t.text     "level_4_description"
    t.float    "weight",                            null: false
    t.integer  "assigned_groups_count", default: 0
  end

  add_index "rubric_criteria", ["assignment_id", "name"], name: "rubric_critera_index_1", unique: true, using: :btree

  create_table "section_due_dates", force: :cascade do |t|
    t.datetime "due_date"
    t.integer  "section_id"
    t.integer  "assignment_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "submission_collectors", force: :cascade do |t|
    t.integer "child_pid"
    t.boolean "stop_child",               default: false
    t.boolean "safely_stop_child_exited", default: false
  end

  create_table "submission_files", force: :cascade do |t|
    t.integer "submission_id"
    t.string  "filename"
    t.string  "path",             default: "/",   null: false
    t.boolean "is_converted",     default: false
    t.boolean "error_converting", default: false
  end

  add_index "submission_files", ["filename"], name: "index_submission_files_on_filename", using: :btree
  add_index "submission_files", ["submission_id"], name: "index_submission_files_on_submission_id", using: :btree

  create_table "submission_rules", force: :cascade do |t|
    t.integer  "assignment_id",                                  null: false
    t.string   "type",          default: "NoLateSubmissionRule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submission_rules", ["assignment_id"], name: "index_submission_rules_on_assignment_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer  "grouping_id"
    t.datetime "created_at"
    t.integer  "submission_version"
    t.boolean  "submission_version_used"
    t.integer  "revision_number",          null: false
    t.datetime "revision_timestamp",       null: false
    t.text     "remark_request"
    t.datetime "remark_request_timestamp"
  end

  add_index "submissions", ["grouping_id"], name: "index_submissions_on_grouping_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",        null: false
    t.string  "description"
    t.integer "user_id"
  end

  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "test_files", force: :cascade do |t|
    t.string   "filename"
    t.integer  "assignment_id"
    t.string   "filetype"
    t.boolean  "is_private"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "test_files", ["assignment_id", "filename"], name: "index_test_files_on_assignment_id_and_filename", unique: true, using: :btree

  create_table "test_results", force: :cascade do |t|
    t.string   "filename"
    t.text     "file_content"
    t.integer  "submission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "user_id"
  end

  add_index "test_results", ["filename"], name: "index_test_results_on_filename", using: :btree
  add_index "test_results", ["submission_id"], name: "index_test_results_on_submission_id", using: :btree

  create_table "tokens", force: :cascade do |t|
    t.integer "grouping_id"
    t.integer "tokens"
    t.date    "last_token_used_date"
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name",                     null: false
    t.string   "last_name"
    t.string   "first_name"
    t.integer  "grace_credits", default: 0,     null: false
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",        default: false, null: false
    t.string   "api_key"
    t.integer  "section_id"
    t.integer  "notes_count",   default: 0
  end

  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true, using: :btree

  add_foreign_key "annotation_texts", "annotation_categories", name: "fk_annotation_labels_annotation_categories", on_delete: :cascade
  add_foreign_key "annotations", "annotation_texts", name: "fk_annotations_annotation_texts"
  add_foreign_key "annotations", "submission_files", name: "fk_annotations_submission_files"
  add_foreign_key "assignment_files", "assignments", name: "fk_assignment_files_assignments", on_delete: :cascade
  add_foreign_key "assignment_stats", "assignments", name: "fk_assignment_stats_assignments", on_delete: :cascade
  add_foreign_key "extra_marks", "results", name: "fk_extra_marks_results", on_delete: :cascade
  add_foreign_key "groupings", "assignments", name: "fk_groupings_assignments"
  add_foreign_key "groupings", "groups", name: "fk_groupings_groups"
  add_foreign_key "marks", "results", name: "fk_marks_results", on_delete: :cascade
  add_foreign_key "memberships", "groupings", name: "fk_memberships_groupings"
  add_foreign_key "memberships", "users", name: "fk_memberships_users"
  add_foreign_key "results", "submissions", name: "fk_results_submissions", on_delete: :cascade
  add_foreign_key "rubric_criteria", "assignments", name: "fk_rubric_criteria_assignments", on_delete: :cascade
  add_foreign_key "submission_files", "submissions", name: "fk_submission_files_submissions"
  add_foreign_key "tags", "users"
end
