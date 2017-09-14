class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :topic
      t.integer :rating
      t.text :review

      t.timestamps
    end
    add_index :reviews, :user_id
    add_index :reviews, :topic_id
  end
end
