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

ActiveRecord::Schema.define(version: 20151107194100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comparisons", force: :cascade do |t|
    t.string   "code",                         null: false
    t.integer  "executions_count", default: 1, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "comparisons", ["code"], name: "index_comparisons_on_code", unique: true, using: :btree

  create_table "comparisons_repositories", force: :cascade do |t|
    t.integer "comparison_id"
    t.integer "repository_id"
  end

  add_index "comparisons_repositories", ["comparison_id", "repository_id"], name: "index_comparisons_repositories_keys", using: :btree
  add_index "comparisons_repositories", ["comparison_id"], name: "index_comparisons_repositories_on_comparison_id", using: :btree
  add_index "comparisons_repositories", ["repository_id"], name: "index_comparisons_repositories_on_repository_id", using: :btree

  create_table "repositories", force: :cascade do |t|
    t.string   "owner",      null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "repositories", ["owner", "name"], name: "index_repositories_on_owner_and_name", unique: true, using: :btree

  add_foreign_key "comparisons_repositories", "comparisons"
  add_foreign_key "comparisons_repositories", "repositories"
end
