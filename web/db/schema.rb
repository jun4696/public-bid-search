# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_24_074724) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bid_documents", force: :cascade do |t|
    t.bigint "bid_id", null: false
    t.string "content_hash"
    t.datetime "created_at", null: false
    t.string "document_type", null: false
    t.string "external_id"
    t.datetime "fetched_at", null: false
    t.string "format", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.index ["bid_id", "external_id"], name: "index_bid_documents_on_bid_id_and_external_id", unique: true
    t.index ["bid_id"], name: "index_bid_documents_on_bid_id"
    t.index ["content_hash"], name: "index_bid_documents_on_content_hash"
    t.index ["document_type"], name: "index_bid_documents_on_document_type"
    t.index ["format"], name: "index_bid_documents_on_format"
  end

  create_table "bid_sources", force: :cascade do |t|
    t.bigint "bid_id", null: false
    t.string "content_hash"
    t.datetime "created_at", null: false
    t.string "external_id"
    t.datetime "fetched_at", null: false
    t.string "format", null: false
    t.bigint "source_id", null: false
    t.string "source_url", null: false
    t.datetime "updated_at", null: false
    t.index ["bid_id"], name: "index_bid_sources_on_bid_id"
    t.index ["content_hash"], name: "index_bid_sources_on_content_hash"
    t.index ["fetched_at"], name: "index_bid_sources_on_fetched_at"
    t.index ["source_id", "external_id"], name: "index_bid_sources_on_source_id_and_external_id", unique: true, where: "(external_id IS NOT NULL)"
    t.index ["source_id"], name: "index_bid_sources_on_source_id"
  end

  create_table "bids", force: :cascade do |t|
    t.date "announcement_date"
    t.date "application_end"
    t.date "application_start"
    t.decimal "bid_amount", precision: 15, scale: 2
    t.date "bid_date"
    t.string "category"
    t.string "contract"
    t.datetime "created_at", null: false
    t.string "department"
    t.string "location"
    t.string "project_period"
    t.date "project_period_end"
    t.date "project_period_start"
    t.text "qualification"
    t.string "source_status"
    t.string "status"
    t.text "summary"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["announcement_date"], name: "index_bids_on_announcement_date"
    t.index ["application_end"], name: "index_bids_on_application_end"
    t.index ["bid_date"], name: "index_bids_on_bid_date"
    t.index ["category"], name: "index_bids_on_category"
    t.index ["status"], name: "index_bids_on_status"
    t.index ["title"], name: "index_bids_on_title"
  end

  create_table "municipalities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "prefecture", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture", "name"], name: "index_municipalities_on_prefecture_and_name", unique: true
  end

  create_table "sources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "municipality_id", null: false
    t.string "name", null: false
    t.string "source_type", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.index ["municipality_id", "name"], name: "index_sources_on_municipality_id_and_name", unique: true
    t.index ["municipality_id"], name: "index_sources_on_municipality_id"
  end

  add_foreign_key "bid_documents", "bids"
  add_foreign_key "bid_sources", "bids"
  add_foreign_key "bid_sources", "sources"
  add_foreign_key "sources", "municipalities"
end
