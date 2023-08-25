require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
  end

  describe '#recent_comments' do
    let!(:author) { User.create!(name: 'John', postCounter: 0) }
    let!(:post) { Post.create!(title: 'Post 1', commentsCounter: 0, likesCounter: 0, author: author) }

    let!(:comment1) { post.comments.create!(author: author) }
    let!(:comment2) { post.comments.create!(author: author) }

    it 'returns the most recent comments' do
      recent_comments = post.recent_comments(2)
      expect(recent_comments).to eq([comment2, comment1])
    end
  end
end
