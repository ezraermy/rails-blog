require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should belong_to(:post) }
  end

  describe '#update_post_comments_counter' do
    let(:user) { User.new }
    let(:post) { Post.new }
    let(:comment1) { Comment.new(author: user, post: post) }
    let(:comment2) { Comment.new(author: user, post: post) }

    before do
      allow(post).to receive_message_chain(:comments, :count).and_return(2)
      post.update_post_comments_counter
    end

    it 'updates the post comments counter' do
      expect(post.commentsCounter).to eq(2)
    end
  end
end
