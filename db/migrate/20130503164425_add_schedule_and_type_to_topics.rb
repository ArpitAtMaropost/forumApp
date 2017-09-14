class AddScheduleAndTypeToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :scheduled_start, :datetime
    add_column :topics, :duration, :integer, :limit => 4
    add_column :topics, :type, :text
    add_index :topics, :type
  end
end
