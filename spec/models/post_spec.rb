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
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_comments' do
    let!(:author) { User.create!(name: 'John', post_counter: 0) }
    let!(:post) { Post.create!(title: 'Post 1', comments_counter: 0, likes_counter: 0, author: author) }

    let!(:comment1) { post.comments.create!(author: author) }
    let!(:comment2) { post.comments.create!(author: author) }

    it 'returns the most recent comments' do
      recent_comments = post.recent_comments(2)
      expect(recent_comments).to eq([comment2, comment1])
    end
  end
end
