Types::RestaurantType = GraphQL::ObjectType.define do
  name "Restaurants"
  description "The restaurants"

  field :id, !types.ID
  field :name, !types.String
  field :description, types.String
  field :restaurant_type, types.String
  field :street, !types.String
  field :city, !types.String
  field :state, !types.String
  field :zipcode, !types.String
  field :googleplaces_id, types.String
  field :lat, !types.String
  field :lng, !types.String
  field :google_types, types.String
  field :created_at, !types.String
  field :updated_at, !types.String
  field :third_party_rating_id, !types.ID
  field :phone, types.String
  field :phone_2, types.String
  field :yelp_url, types.String
  field :foursquare_url, types.String
  field :googleplaces_url, types.String
  field :zomato_url, types.String
  field :yelp_id, !types.String
  field :foursquare_id, types.String
  field :zomato_id, types.String
end
