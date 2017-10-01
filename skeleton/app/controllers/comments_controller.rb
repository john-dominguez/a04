class CommentsController < ApplicationController

  before_action :require_login


  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.link_id = params[:link_id]
    if @comment.save
      redirect_to link_url(@comment.link)
    else
      flash[:errors] = @comment.errors.full_messages
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to link_url(@comment.link)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
