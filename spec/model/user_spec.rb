require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key(:author_id) }
    it { should have_many(:comments).with_foreign_key(:author_id) }
    it { should have_many(:likes).with_foreign_key(:author_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:postCounter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_posts' do
    let!(:user) { User.create!(name: 'John', postCounter: 0) }

    let!(:post1) { user.posts.create!(title: 'Post 1', commentsCounter: 0, likesCounter: 0) }
    let!(:post2) { user.posts.create!(title: 'Post 2', commentsCounter: 0, likesCounter: 0) }

    it 'returns the most recent posts' do
      recent_posts = user.recent_posts(2)
      expect(recent_posts).to eq([post2, post1])
    end
  end
end
