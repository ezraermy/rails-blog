class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :postCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
