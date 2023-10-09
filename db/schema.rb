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

ActiveRecord::Schema[7.0].define(version: 2023_10_06_110935) do
  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "librarian_id", null: false
    t.index ["librarian_id"], name: "index_books_on_librarian_id"
  end

  create_table "borrowings", force: :cascade do |t|
    t.date "due_date"
    t.string "return_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.index ["book_id"], name: "index_borrowings_on_book_id"
    t.index ["user_id"], name: "index_borrowings_on_user_id"
  end

  create_table "librarians", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "books", "librarians"
  add_foreign_key "borrowings", "books"
  add_foreign_key "borrowings", "users"
end