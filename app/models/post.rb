class Post < ActiveRecord::Base
  attr_accessible :title, :body

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  belongs_to :user
  default_scope order: 'posts.created_at desc'
end
