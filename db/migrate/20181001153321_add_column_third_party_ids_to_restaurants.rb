class AddColumnThirdPartyIdsToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :yelp_id, :string
    add_column :restaurants, :foursquare_id, :string
    add_column :restaurants, :zomato_id, :string
  end
end
