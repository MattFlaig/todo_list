class User < ActiveRecord::Base

  has_many :todo_items
  has_secure_password :validations => false

  validates :email, presence: true, uniqueness: true, format:/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :username, presence: true
  validates :password, presence: true
end
