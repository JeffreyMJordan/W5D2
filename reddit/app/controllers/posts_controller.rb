class PostsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @sub = Sub.find_by_id(params[:sub_id])
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to sub_post_url(params[:sub_id], @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end

  end

  def show
    @sub = Sub.find_by_id(params[:sub_id])
    @post = Post.find_by_id(params[:id])
    render :show
  end

  def index
  end

  def destroy
  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
