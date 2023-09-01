class Api::V1::PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :asc)
    render json: @posts
  end
end
