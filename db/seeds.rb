# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

num_users = 50

## Generate Restaurants
Restaurant.destroy_all
# num_restaurants = num_users / 2
# puts "Seeding restaurants..."
# num_restaurants.times do
#   name = Faker::Restaurant.name
#   description = Faker::Restaurant.description
#   restaurant_type = Faker::Restaurant.type
#   street = Faker::Address.street_address
#   city = Faker::Address.city
#   state = Faker::Address.state_abbr
#   zipcode = Faker::Address.zip_code
#
#   Restaurant.create(name: name, description: description, restaurant_type: restaurant_type, street: street, city: city, state: state, zipcode: zipcode)
# end
# puts "Restaurants - #{num_restaurants} created."

## Generate Reviews
Review.destroy_all
# num_reviews = num_restaurants * 10
# puts "Seeding reviews..."
# num_reviews.times do
#   user_id = 1
#   restaurant_id = Restaurant.pluck(:id).sample
#   review_text = Faker::FamousLastWords.last_words
#   review_score = Random.new.rand(5)
#   Review.create(user_id: user_id, restaurant_id: restaurant_id, review_text: review_text, review_score: review_score)
# end
# puts "Reviews - #{num_reviews} created."
