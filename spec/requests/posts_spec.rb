require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET index' do
    let(:user) { User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I am a teacher', postCounter: 1) }
    it 'returns a 200 OK status code and renders the correct template' do
      get user_posts_path(user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of posts')
    end
  end

  describe 'GET show' do
    let(:user) { User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I am a teacher', postCounter: 1) }
    let(:post) do
      Post.create(title: 'AI', content: 'Great post', commentsCounter: 1, likesCounter: 1,
                  author: user)
    end

    it 'returns a 200 OK status code and renders the correct template' do
      get user_post_path(post.author, post)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end

    it 'includes the correct text in the response body' do
      get user_post_path(post.author, post)
      expect(response.body).to include('Post details')
    end
  end
end
