class AddColumnToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :google_places_id, :string
    add_column :restaurants, :google_lat, :string
    add_column :restaurants, :google_lng, :string
    add_column :restaurants, :google_types, :string
  end
end
