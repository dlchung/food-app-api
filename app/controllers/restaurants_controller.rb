require 'rest-client'

GOOGLE_PLACES_API_KEY = Rails.application.credentials.google[:places][:api_key]

class RestaurantsController < ApplicationController
  def nearby
    location = params[:location]
    radius = params[:radius]
    type = params[:type]
    keyword = params[:keyword]

    restaurants = self.create_listings(location, radius, type, keyword)

    render json: restaurants
  end

  def rating
    platform = params[:platform]
    restaurant_id = params[:restaurant_id]

    rating = get_restaurant_rating(restaurant_id, platform)

    json_rating = {"#{platform}Rating": rating[platform]}

    render json: json_rating
  end

  def place_details(place_id)
    Geocoder.search(place_id)
  end

  def create_listings(location, radius, type, keyword)
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{GOOGLE_PLACES_API_KEY}&location=#{location}&radius=#{radius}&type=#{type}&keyword=#{keyword}"
    response = JSON.parse(RestClient.get(url))
    restaurant_data = response["results"]

    restaurants = restaurant_data.map do |restaurant|
      # puts restaurant
      existing_restaurant = Restaurant.find_by(google_places_id: restaurant["place_id"])
      # puts existing_restaurant
      if !existing_restaurant
        # puts "DOES NOT EXIST"
        place_data = self.place_details(restaurant["place_id"])
        place_details = place_data.first
        name = restaurant["name"]
        street = place_details.street_address
        city = place_details.city
        state = place_details.state
        zipcode = place_details.postal_code
        google_places_id = place_details.place_id
        google_lat = place_details.latitude
        google_lng = place_details.longitude
        googleplaces_url = place_details.data["url"]
        phone = place_details.data["formatted_phone_number"]

        new_restaurant = Restaurant.create_with(name: name, street: street, city: city, state: state, zipcode: zipcode, google_lat: google_lat, google_lng: google_lng, googleplaces_url: googleplaces_url, phone: phone).find_or_create_by(google_places_id: google_places_id)
        third_party_rating = ThirdPartyRating.create
        third_party_rating.googleplaces = place_details.data["rating"]
        third_party_rating.save
        new_restaurant.third_party_rating = third_party_rating
        new_restaurant.save
        new_restaurant
      else
        # puts "EXISTS"
        existing_restaurant
      end
    end

    restaurants
  end

  def get_restaurant_rating(id, platform)
    restaurant = Restaurant.find(id)
    restaurant.set_third_party_rating(platform)
  end
end
