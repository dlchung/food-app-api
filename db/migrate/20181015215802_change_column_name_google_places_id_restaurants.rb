class ChangeColumnNameGooglePlacesIdRestaurants < ActiveRecord::Migration[5.2]
  def change
    rename_column :restaurants, :google_places_id, :googleplaces_id
  end
end
