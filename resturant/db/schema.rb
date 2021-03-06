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

ActiveRecord::Schema.define(version: 20160821225542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "items_menus", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "menu_id"
    t.index ["item_id"], name: "index_items_menus_on_item_id", using: :btree
    t.index ["menu_id"], name: "index_items_menus_on_menu_id", using: :btree
  end

  create_table "items_orders", force: :cascade do |t|
    t.integer "item_id"
    t.integer "order_id"
    t.index ["item_id"], name: "index_items_orders_on_item_id", using: :btree
    t.index ["order_id"], name: "index_items_orders_on_order_id", using: :btree
  end

  create_table "menus", force: :cascade do |t|
    t.string   "types"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "address"
    t.string   "phone"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "orders", "users"
end
