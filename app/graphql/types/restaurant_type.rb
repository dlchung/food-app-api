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
  field :google_places_id, !types.String
  field :google_lat, !types.String
  field :google_lng, !types.String
  field :google_types, types.String
  field :created_at, !types.String
  field :updated_at, !types.String
  field :third_party_rating, !types.ID
end
