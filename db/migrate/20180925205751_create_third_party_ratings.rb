class CreateThirdPartyRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :third_party_ratings do |t|
      t.integer :yelp

      t.timestamps
    end
  end
end
