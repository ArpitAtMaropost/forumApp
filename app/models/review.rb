class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  attr_accessible :rating, :review

  validates :review, :presence => true
  validates :rating, :presence => true

  validate :uniqueness

  private

  def uniqueness
    errors.add(:base, "Already reviewed this topic") if self.new_record? &&
        !self.class.where(:topic_id => self.topic_id, :user_id => self.user_id).empty?
  end
end
