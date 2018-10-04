class LocationsController < ApplicationController
  def create
    name = params[:name]
    address = params[:address]
    location = Location.create(name:name, address: address)

    render json: location
  end

  def delete
    id = params[:id]
    location = Location.find(id).delete

    render json: location
  end

  def get_locations
    render json: Location.all
  end
end
