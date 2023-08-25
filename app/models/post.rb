class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  
  after_create :update_user_post_counter
  after_create :update_post_comments_counter

  after_destroy :update_user_post_counter
  after_destroy :update_post_comments_counter

  def update_user_post_counter
    author.update(postCounter: author.posts.count)
  end

  def update_post_comments_counter
    update(commentsCounter: comments.count)
  end

  def update_post_likes_counter
    update(likesCounter: likes.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
