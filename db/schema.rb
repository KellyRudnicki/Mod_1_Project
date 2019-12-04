# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_04_215642) do

  create_table "fantasy_teams", force: :cascade do |t|
    t.string "team_name"
    t.integer "league_id"
    t.index ["league_id"], name: "index_fantasy_teams_on_league_id"
  end

  create_table "league_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "league_id"
    t.index ["league_id"], name: "index_league_users_on_league_id"
    t.index ["user_id"], name: "index_league_users_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "league_name"
  end

  create_table "player_teams", force: :cascade do |t|
    t.integer "player_id"
    t.integer "fantasy_team_id"
    t.index ["fantasy_team_id"], name: "index_player_teams_on_fantasy_team_id"
    t.index ["player_id"], name: "index_player_teams_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.integer "points"
    t.integer "goals"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
  end

  add_foreign_key "league_users", "leagues"
  add_foreign_key "league_users", "users"
  add_foreign_key "player_teams", "fantasy_teams"
  add_foreign_key "player_teams", "players"
end
