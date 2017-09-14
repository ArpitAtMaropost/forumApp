class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.integer :creator_id
      t.integer :presenter_id

      t.timestamps
    end
    add_index :topics, :creator_id
    add_index :topics, :presenter_id
  end
end
