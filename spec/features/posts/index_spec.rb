require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  describe 'Post index page' do
    before(:each) do
      @user = User.create(name: 'Emmanuel',
                          photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'I am a user', postCounter: 1)
      @post = Post.create(title: 'First', content: 'First post', commentsCounter: 2, likesCounter: 1, author: @user)
      @first_comment = Comment.create(text: 'First comment', author: @user, post: @post)
      Like.create(author: @user, post: @post)
      visit user_posts_path(user_id: @user.id)
    end

    it "shows user's profile picture" do
      expect(page).to have_css('img')
    end

    it "shows the user's username" do
      expect(page).to have_content(@post.author.name)
    end

    it 'shows the number of posts the user has written' do
      expect(page).to have_content(@post.author.postCounter)
    end

    it 'shows the post title' do
      expect(page).to have_content(@post.title)
    end

    it "shows the post's body" do
      expect(page).to have_content(@post.content)
    end

    it 'shows the first comments on a post' do
      expect(page).to have_content('First comment')
    end

    it 'should render the number of comments' do
      expect(page).to have_content(@post.commentsCounter)
    end

    it 'should render the number of likes' do
      expect(page).to have_content(@post.likesCounter)
    end

    it 'should render the pagenation button' do
      expect(page).to have_content('Pagination')
    end

    it "Redirects to the post's show page when the post's title is clicked" do
      click_link(@post.title)
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
    end
  end
end
