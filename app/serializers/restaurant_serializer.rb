class RestaurantSerializer
  include FastJsonapi::ObjectSerializer
  has_many :reviews
  set_type :restaurant
  attributes :name, :description, :restaurant_type, :street, :city, :state, :zipcode
end
