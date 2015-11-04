# comments_controller
class CommentsController < ApplicationController
  before_filter :find_post,    only: [:new, :create]
  before_filter :find_comment, only: [:edit, :update, :destroy]
  def new
    @comment = @post.comments.build
    @comment.user_id = current_user.id
    redirect_to :back
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.json do
          render json: {
            comment: @comment, user_avatar: @comment.user.avatar.url(:medium),
            user: @comment.user
          }
          
        end
      else
        format.json { render json: { status: 500 } }
      end
    end
  end

  def update
     if @comment.update(comment_params)
       redirect_to @comment.post, notice: 'Comment was updated'
     else
       render 'edit'
     end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_url}
      format.json { head :no_content }
      format.js { render :layout => false }
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
