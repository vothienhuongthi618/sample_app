class Post < ActiveRecord::Base
  attr_accessible :body, :state, :title, :tags_attributes, :tag_list, :permalink
  belongs_to :user

  has_many :tags, dependent: :destroy

  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k,v| v.blank? } }
    
  has_permalink :title
  
  validates :permalink, presence: true
  validates :user_id, presence: true
  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :state, presence: true
  default_scope order: 'posts.created_at DESC'

  
	DRAFT_STATE = 0
	COMPLETE_STATE = 1
	PUBLISH_STATE = 2
	TOSS_STATE = 3


  def tag_list
    self.tags.map { |t| t.name }.join(", ")
  end

  def tag_list=(new_value)
    tag_names = new_value.split(/,\s+/)
    self.tags = tag_names.map { |name| Tag.where('name = ?', name).first or Tag.create(:name => name) }
  end

end
