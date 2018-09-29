# module Types
  # class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World! HELLO"
    # end


  # end
# end

Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :restaurant do
    type Types::RestaurantType
    argument :id, !types.ID
    description "Find a restaurant by ID"
    resolve ->(obj, args, ctx) {
      Restaurant.find_by(id: args[:id])
    }
  end

  field :allRestaurants, !types[Types::RestaurantType] do
    resolve -> (obj, args, ctx) { Restaurant.all.limit(20).shuffle }
  end

  # field :nearbyRestaurants, !types[Types::RestaurantType] do
  #   resolve -> (obj, args, ctx) { Restaurant.all }
  # end
end
