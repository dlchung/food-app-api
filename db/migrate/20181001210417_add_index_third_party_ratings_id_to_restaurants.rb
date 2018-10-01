class AddIndexThirdPartyRatingsIdToRestaurants < ActiveRecord::Migration[5.2]
  def change
    change_table :restaurants do |t|
      t.index :google_lat
      t.index :google_lng
      t.index :google_places_id
      t.index :third_party_rating_id
    end
  end
end
