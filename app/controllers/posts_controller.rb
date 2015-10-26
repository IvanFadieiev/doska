class PostsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
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
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @avatar = @user.avatar
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: 'Post was successfully delit.'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
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
    @user = User.find(params[:user_id])
    @avatar = @user.avatar
  end

  private

  def post_params
    params.require(:post).permit(:poster, :body)
  end
end
