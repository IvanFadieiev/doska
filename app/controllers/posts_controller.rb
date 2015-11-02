# posts_controller
class PostsController < ApplicationController
  before_filter :find_post, only: [:show, :destroy, :edit, :update]
  before_filter :find_user, only: [:new, :avatar, :create]
  respond_to :html, :js
  def create
    @post = @user.posts.create(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def new
    @post = @user.posts.build
  end

  def show
    @user = @post.user
    @avatar = @user.avatar
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: 'Post was successfully delit.'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post was updated'
    else
      render 'edit'
    end
  end

  def my_posts
    @post = current_user.posts
  end

  def avatar  
    @avatar = @user.avatar
  end

  private

  def post_params
    params.require(:post).permit(:poster, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
