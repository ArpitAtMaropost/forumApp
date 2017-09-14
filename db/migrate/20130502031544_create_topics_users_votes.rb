class CreateTopicsUsersVotes < ActiveRecord::Migration
  def change
    create_table :topics_users_votes do |t|
      t.references :user
      t.references :topic

      t.timestamps
    end
    add_index :topics_users_votes, [:user_id,:topic_id]
    add_index :topics_users_votes, :topic_id
    add_index :topics_users_votes, :user_id
  end
end
