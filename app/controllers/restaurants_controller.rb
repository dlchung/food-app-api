require 'rest-client'

GOOGLE_PLACES_API_KEY = Rails.application.credentials.google[:places]

class RestaurantsController < ApplicationController
  # def index
  #   render json: RestaurantSerializer.new(restaurants).serialized_json
  # end
  #
  # def show
  #   # render json: RestaurantSerializer.new(restaurant).serialized_json
  # end

  # def create
  #   @restaurant = Restaurant.new(restaurant_params)
  #
  #   if @restaurant.save
  #     # render json: @restaurant
  #   else
  #     # render json: @restaurant.errors
  #   end
  # end
  #
  # private
  #
  # def restaurant_params
  #   params.require(:restaurant).permit(:name, :description, :restaurant_type, :street, :city, :state, :zipcode)
  # end

  def nearby
    location = params[:location]
    radius = params[:radius]
    type = params[:type]
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{GOOGLE_PLACES_API_KEY}&location=#{location}&radius=#{radius}&type=#{type}"
    response = JSON.parse(RestClient.get(url))
    # puts response["results"]
    restaurant_data = response["results"]

    restaurant_data.each do |restaurant|
      # puts restaurant
      place_data = self.place_details(restaurant["place_id"])
      place_details = place_data["results"][0]["address_components"]
      # puts place_details["address_components"]
      puts place_details
      # new_restaurant = Restaurant.new
      # new_restaurant.name = restaurant["name"]
      # new_restaurant.street = "#{place_details[0]["long_name"]} #{place_details[1]["long_name"]}"
      # new_restaurant.city = place_details[3]["long_name"]
      # new_restaurant.state = place_details[5]["short_name"]
      # new_restaurant.zipcode = "#{place_details[7]["long_name"]}-#{place_details[8]["long_name"]}"
      # new_restaurant.google_places_id = restaurant["place_id"]
      # new_restaurant.google_lat = restaurant["geometry"]["location"]["lat"]
      # new_restaurant.google_lng = restaurant["geometry"]["location"]["lng"]
      # new_restaurant.google_types = restaurant.types
      # puts new_restaurant
      # new_restaurant.save
    end

    render json: response
  end

  def place_details(place_id)url = "https://maps.googleapis.com/maps/api/geocode/json?place_id=#{place_id}&key=#{GOOGLE_PLACES_API_KEY}"
    JSON.parse(RestClient.get(url))
  end
end
