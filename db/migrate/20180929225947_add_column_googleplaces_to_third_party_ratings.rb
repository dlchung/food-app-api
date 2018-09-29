class AddColumnGoogleplacesToThirdPartyRatings < ActiveRecord::Migration[5.2]
  def change
    add_column :third_party_ratings, :googleplaces, :decimal
  end
end
