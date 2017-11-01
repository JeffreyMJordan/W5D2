class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    @post = Post.find_by_id(params[:post_id])
    @sub = Sub.find_by_id(params[:sub_id])
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to sub_post_url(@sub, @post)
  end

  def show
    @comment = Comment.find_by_id(params[:id])
    render :show
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
