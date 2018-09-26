require 'rest-client'

GOOGLE_PLACES_API_KEY = Rails.application.credentials.google[:places][:api_key]

class RestaurantsController < ApplicationController
  def nearby
    location = params[:location]
    radius = params[:radius]
    type = params[:type]

    restaurants = self.create_listings(location, radius, type)
    # puts restaurants
    render json: restaurants
  end

  def place_details(place_id)
    # url = "https://maps.googleapis.com/maps/api/geocode/json?place_id=#{place_id}&key=#{GOOGLE_PLACES_API_KEY}"
    # JSON.parse(RestClient.get(url))
    Geocoder.search(place_id)
  end

  def create_listings(location, radius, type)
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{GOOGLE_PLACES_API_KEY}&location=#{location}&radius=#{radius}&type=#{type}"
    puts url
    response = JSON.parse(RestClient.get(url))
    restaurant_data = response["results"]

    restaurants = restaurant_data.map do |restaurant|
      existing_restaurant = Restaurant.find_by(google_places_id: restaurant["place_id"])
      if !existing_restaurant
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

        Restaurant.create_with(name: name, street: street, city: city, state: state, zipcode: zipcode, google_lat: google_lat, google_lng: google_lng)
        .find_or_create_by(google_places_id: google_places_id)
      else
        existing_restaurant
      end
    end

    restaurants
  end
end
