class CreateTagsTopics < ActiveRecord::Migration
  def change
    create_table :tags_topics do |t|
      t.references :tag
      t.references :topic
    end
    add_index :tags_topics, :tag_id
    add_index :tags_topics, :topic_id
  end
end
