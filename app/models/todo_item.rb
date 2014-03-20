class TodoItem < ActiveRecord::Base
  validates :comment, :content, :name, :deadline, presence: true
  belongs_to :user
end
