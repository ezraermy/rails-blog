class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @like = Like.new
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params)
    @post.author = current_user
    @post.commentsCounter = 0
    @post.likesCounter = 0
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to user_posts_path(current_user)
    else
      flash[:error] = 'Post not created!'
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
