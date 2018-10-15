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

ActiveRecord::Schema.define(version: 2018_10_13_194125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "restaurant_type"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_places_id"
    t.string "lat"
    t.string "lng"
    t.string "google_types"
    t.integer "third_party_rating_id"
    t.string "phone"
    t.string "phone_2"
    t.string "yelp_url"
    t.string "foursquare_url"
    t.string "googleplaces_url"
    t.string "zomato_url"
    t.string "yelp_id"
    t.string "foursquare_id"
    t.string "zomato_id"
    t.index ["google_places_id"], name: "index_restaurants_on_google_places_id"
    t.index ["lat"], name: "index_restaurants_on_lat"
    t.index ["lng"], name: "index_restaurants_on_lng"
    t.index ["third_party_rating_id"], name: "index_restaurants_on_third_party_rating_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "restaurant_id"
    t.string "review_text"
    t.string "review_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "third_party_ratings", force: :cascade do |t|
    t.decimal "yelp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "foursquare"
    t.decimal "googleplaces"
    t.decimal "zomato"
  end

  create_table "users_groups", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
