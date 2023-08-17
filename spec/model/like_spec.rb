require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should belong_to(:post) }
  end

  describe '#update_post_likes_counter' do
    let(:user) { User.new }
    let(:post) { Post.new }
    let(:like1) { Like.new(author: user, post: post) }
    let(:like2) { Like.new(author: user, post: post) }

    before do
      allow(post).to receive_message_chain(:likes, :count).and_return(2)
      post.update_post_likes_counter
    end

    it 'updates the post likes counter' do
      expect(post.likesCounter).to eq(2)
    end
  end
end
