class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :commentsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likesCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
