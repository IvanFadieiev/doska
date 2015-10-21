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
    @post = Post.all
  end
  # создаем пост для вошедшего юзера
  def new
  @user = User.find(params[:user_id]) # ищем юзера в User по id из модели posts
  @post = @user.posts.build           # строим пост в модели Post именно этим юзером
  end
  # ищем все посты с id пользователя 
  def show
  @user = User.find(params[:id])      # ищем юзера в User
  @post = @user.posts                 # показываем все сообщения этого юзера
  end

  private
  def post_params
  params.require(:post).permit(:poster, :body)
  end
end
