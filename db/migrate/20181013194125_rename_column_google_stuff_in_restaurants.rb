class RenameColumnGoogleStuffInRestaurants < ActiveRecord::Migration[5.2]
  def change
    rename_column :restaurants, :google_lat, :lat
    rename_column :restaurants, :google_lng, :lng
  end
end
