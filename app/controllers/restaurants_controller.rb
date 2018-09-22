require 'rest-client'

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
    api_key = Rails.application.credentials.google[:places]
    location = params[:location]
    radius = params[:radius]
    type = params[:type]
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{api_key}&location=#{location}&radius=#{radius}&type=#{type}"
    response = RestClient.get(url)

    render json: response
  end
end
