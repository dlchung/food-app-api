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
end
