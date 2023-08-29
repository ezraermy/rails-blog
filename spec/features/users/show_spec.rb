require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe 'User show page' do
    before(:each) do
      @user = User.create(name: 'Buchu',
                          photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Ethiopa.',
                          postCounter: 3)
      @first_post = Post.create(title: 'First', content: 'First post', commentsCounter: 1, likesCounter: 2,
                                author: @user)
      @second_post = Post.create(title: 'Second', content: 'Second post', commentsCounter: 1, likesCounter: 2,
                                 author: @user)
      @third_post = Post.create(title: 'Third', content: 'Third post', commentsCounter: 1, likesCounter: 2,
                                author: @user)

      visit user_path(id: @user.id)
    end

    it "shows the user's username" do
      expect(page).to have_content('Buchu')
    end

    it 'shows the number of posts the user has written' do
      expect(page).to have_content(@user.postCounter)
    end

    it "shows the user's profile picture" do
      expect(page).to have_css('img')
    end

    it "shows the user's bio" do
      expect(page).to have_content('Teacher from Ethiopa.')
    end

    it "should have a button to see all the user's posts" do
      expect(page).to have_link('See all posts')
    end

    it "should redirect to that post's show page" do
      click_link @first_post.title
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @first_post.id))
    end

    it "should render the user's first 3 posts" do
      expect(page).to have_content('First')
      expect(page).to have_content('Second')
      expect(page).to have_content('Third')
    end

    it "Redirected to the user's posts page when clicking on the 'See all posts' button" do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(user_id: @user.id))
    end
  end
end
