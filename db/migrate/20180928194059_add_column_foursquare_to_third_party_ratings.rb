class AddColumnFoursquareToThirdPartyRatings < ActiveRecord::Migration[5.2]
  def change
    add_column :third_party_ratings, :foursquare, :decimal
  end
end
