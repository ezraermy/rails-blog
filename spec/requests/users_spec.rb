require 'rails_helper'

RSpec.describe 'requests', type: :request do
  describe 'GET index' do
    it 'returns a 200 OK status code and renders the correct template' do
      get users_path
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of users')
    end
  end

  describe 'GET show' do
    let(:user) { User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I am a teacher', postCounter: 1) }

    it 'returns a 200 OK status code and renders the correct template' do
      get user_path(user)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end

    it 'includes the correct text in the response body' do
      get user_path(user)
      expect(response.body).to include('User details')
    end
  end
end
