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

ActiveRecord::Schema.define(version: 20171229104025) do

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id"
    t.string "timestart"
    t.string "timeend"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seat_id"
    t.integer "table_id"
    t.index ["seat_id"], name: "index_bookings_on_seat_id"
    t.index ["table_id"], name: "index_bookings_on_table_id"
  end

  create_table "checks", force: :cascade do |t|
    t.string "floor"
    t.string "zone"
    t.string "with_charge"
    t.string "with_window"
    t.string "timestart"
    t.string "timeend"
    t.boolean "confirmation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "micropost_id"
    t.integer "user_id"
    t.index ["micropost_id"], name: "index_comments_on_micropost_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "microposts", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "seat_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "table_id"
    t.index ["table_id"], name: "index_seats_on_table_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "table_number"
    t.string "floor"
    t.string "zone"
    t.string "with_window"
    t.string "with_charge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_number"], name: "index_tables_on_table_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_token"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
