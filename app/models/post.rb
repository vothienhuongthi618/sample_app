class Post < ActiveRecord::Base
  attr_accessible :body, :state, :title
  belongs_to :user

  validates :user_id, presence: true
  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :state, presence: true
  default_scope order: 'posts.created_at DESC'

  
	DRAFT_STATE = 0
	COMPLETE_STATE = 1
	PUBLISH_STATE = 2
	TOSS_STATE = 3


end
