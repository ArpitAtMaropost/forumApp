class Tag < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :tags_topics, :dependent => :destroy
  has_and_belongs_to_many :topics

  validates :name, :presence => true
end
