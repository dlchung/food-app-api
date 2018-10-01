class AddColumnZomatoToThirdPartyRatings < ActiveRecord::Migration[5.2]
  def change
    add_column :third_party_ratings, :zomato, :decimal
  end
end
