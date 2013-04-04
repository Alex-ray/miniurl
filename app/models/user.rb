class User < ActiveRecord::Base
  validates :email, :uniqueness => true
  validates :user_name, :uniqueness => true

  has_many :urls
end
