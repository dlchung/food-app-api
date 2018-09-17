class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :description
      t.string :restaurant_type
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps
    end
  end
end
