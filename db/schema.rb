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

ActiveRecord::Schema.define(version: 20161007065359) do

  create_table "donations", force: :cascade do |t|
    t.integer  "period_id"
    t.string   "receipt_no"
    t.string   "name",       null: false
    t.text     "address"
    t.string   "phone"
    t.decimal  "amount",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["period_id"], name: "index_donations_on_period_id"
  end

  create_table "periods", force: :cascade do |t|
    t.string   "name",                 null: false
    t.integer  "status_cd",  limit: 1, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
