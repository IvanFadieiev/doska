class PostsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    if @post.save
        redirect_to user_posts_path, notice: 'Post was successfully created.'
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
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
    redirect_to :back, notice: 'Post was successfully delit.'
    end
  end
def edit
  @post = Post.find(params[:id])
end
def update
    @post = Post.find(params[:id])
  if @post.update(post_params)
      redirect_to user_posts_path(@post), notice: 'Post was successfully updated'
  else
    render 'edit'
  end
end

private
  def post_params
  params.require(:post).permit(:poster, :body)
  end
end
