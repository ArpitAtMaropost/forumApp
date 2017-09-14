class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :topics, :foreign_key => :creator_id
  has_many :project_topics, :foreign_key => :creator_id
  has_many :voted_topics, :class_name => 'Topic', :through => :topics_users_votes
  has_many :reviews

  # attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :admin, :import_id


  alias_attribute :name, :username

  def to_s
    self.username
  end

  def admin?
    @admin ||= ["arpit@maropost.com"].include? self.email.downcase
  end
end
