class Post < ActiveRecord::Base
  attr_accessible :body, :state, :title
  belongs_to :user

  validates :user_id, presence: true
  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  before_save :to_complete_state
  default_scope order: 'posts.created_at DESC'

  private 
  	DRAFT_STATE = 0
  	COMPLETE_STATE = 1
  	PUBLISH_STATE = 2
  	TOSS_STATE = 3
    def to_draft_state
      self.state = DRAFT_STATE
    end
    def to_complete_state
      self.state = COMPLETE_STATE
    end
    def to_publish_state
      self.state = PUBLISH_STATE
    end
    def to_toss_state
      self.state = TOSS_STATE
    end
end
