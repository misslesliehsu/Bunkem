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

ActiveRecord::Schema.define(version: 20180104181436) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "definitions", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_definitions_on_game_id"
    t.index ["user_id"], name: "index_definitions_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "word"
    t.integer "player_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "points_hash"
    t.integer "battle_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_participants_on_game_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lifetime_pts", default: 0
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "voter_id"
    t.bigint "definition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["definition_id"], name: "index_votes_on_definition_id"
    t.index ["voter_id"], name: "index_votes_on_voter_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.string "definition"
  end

  add_foreign_key "definitions", "games"
  add_foreign_key "definitions", "users"
  add_foreign_key "participants", "games"
  add_foreign_key "participants", "users"
  add_foreign_key "votes", "definitions"
  add_foreign_key "votes", "users", column: "voter_id"
end
