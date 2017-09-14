class TopicsUsersVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  validates :user_id, :uniqueness => {:scope => :topic_id, :message => 'Already voted this topic'}
end
