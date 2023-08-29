require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe 'User index page' do
    before(:each) do
      @user = User.create(name: 'Tom',
                          photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Mexico.')
      visit users_path
    end

    it 'Redirected to the user show page when clicking on the username' do
      User.all.each do |user|
        click_link('Tom')
        expect(page).to have_current_path(user_path(user.id))
      end
    end

    it 'shows the username of all other users' do
      User.all.each do |_user|
        expect(page).to have_content('Tom')
      end
    end

    it 'shows the number of posts each user has written' do
      User.all.each do |_user|
        expect(page).to have_content('Number of posts: 0')
      end
    end

    it 'shows the profile picture for each user' do
      User.all.each do |_user|
        expect(page).to have_css('img')
      end
    end
  end
end
