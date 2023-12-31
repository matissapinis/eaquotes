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

ActiveRecord::Schema[7.0].define(version: 2023_08_11_144118) do
  create_table "downvotes", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quote_id", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quote_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quote_id"], name: "index_favorites_on_quote_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.text "content"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attribution"
    t.string "source"
    t.string "source_link"
    t.text "comment"
    t.integer "user_id"
    t.index ["user_id"], name: "index_quotes_on_user_id"
  end

  create_table "quotes_topics", force: :cascade do |t|
    t.integer "quote_id", null: false
    t.integer "topic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quote_id"], name: "index_quotes_topics_on_quote_id"
    t.index ["topic_id"], name: "index_quotes_topics_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "upvotes", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quote_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_name"
    t.string "full_name"
    t.string "facebook_link"
    t.string "twitter_link"
    t.string "ea_forum_link"
    t.string "lesswrong_link"
    t.string "goodreads_link"
    t.boolean "admin", default: false
    t.boolean "display_full_name"
    t.boolean "display_favorites"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favorites", "quotes"
  add_foreign_key "favorites", "users"
  add_foreign_key "quotes", "users"
  add_foreign_key "quotes_topics", "quotes"
  add_foreign_key "quotes_topics", "topics"
end
