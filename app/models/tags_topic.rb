class TagsTopic < ActiveRecord::Base
  belongs_to :tag
  belongs_to :topic
  # attr_accessible :title, :body
end
