class AddThirdPartyRatingToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :third_party_rating_id, :integer
  end
end
