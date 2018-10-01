class AddColumnsMoreDetailsToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :phone, :string
    add_column :restaurants, :phone_2, :string
    add_column :restaurants, :yelp_url, :string
    add_column :restaurants, :foursquare_url, :string
    add_column :restaurants, :googleplaces_url, :string
    add_column :restaurants, :zomato_url, :string
  end
end
