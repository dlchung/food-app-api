class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :review_text
      t.string :review_score

      t.timestamps
    end
  end
end
