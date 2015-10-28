# comments_controller
class CommentsController < ApplicationController
  before_filter :find_post,    only: [:new, :create]
  before_filter :find_comment, only: [:update, :destroy]
  def new
    @comment = @post.comments.build
    @comment.user_id = current_user.id
    redirect_to :back
  end

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to :back
    else
      render new
    end
  end

  def edit
    @comment = Comment.find(params[:post_id])
  end

  def update
     if @comment.update(comment_params)
       redirect_to @comment.post, notice: 'Comment was updated'
     else
       render 'edit'
     end
  end

  def destroy
    if @comment.destroy
      redirect_to :back, notice: 'Comment was  delit.'
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end
  
  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
