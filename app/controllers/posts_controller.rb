class PostsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    if @post.save
        redirect_to user_path(@user), notice: 'Post was successfully created.'
       else
        render 'new'
     end
    #redirect_to user_path(@user)
  end

  def index
    @posts = Post.all
  end

  private
  def post_params
  params.require(:post).permit(:poster, :body)
end
 end
