class Topic < ActiveRecord::Base
  belongs_to :presenter, :class_name => 'User', :foreign_key => :presenter_id
  belongs_to :creator, :class_name => 'User', :foreign_key => :creator_id
  has_many :votes, :class_name => 'TopicsUsersVote', :dependent => :destroy
  has_many :voting_users, :class_name => 'User', :through => :topics_users_votes
  has_many :reviews

  has_many :tags_topics, :dependent => :destroy
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  attr_accessor :unscheduled
  attr_accessible :description, :title, :duration, :tag_ids

  validates :title, :description, :creator, :duration, :presence => true

  scope :unscheduled, where(:'scheduled_start' => nil)
  scope :past, where(['scheduled_start < ?', Time.zone.now])
  scope :future, where(['scheduled_start > ?', Time.zone.now])
  scope :scheduled, where(['scheduled_start is not null']).order('scheduled_start desc')
  scope :non_project, where('type' => nil)

  def self.upcoming_grouped_by_date
    future.scheduled.group_by { |t| t.scheduled_start.to_date }
  end

  def self.past_grouped_by_date
    past.scheduled.group_by { |t| t.scheduled_start.to_date }
  end
end
