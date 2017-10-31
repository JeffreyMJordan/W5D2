class ModeratorsController < ApplicationController
  before_action :ensure_is_moderator
  before_action :ensure_logged_in

  def new
    @sub = Sub.find_by_id(params[:sub_id])
    render :new
  end


  def create
    user = User.find_by_username(mod_params[:username])
    if (user.nil?)
      flash[:errors] = ["Invalid user"]
      redirect_to new_sub_moderator_url(params[:sub_id])
    end
    @mod = Moderator.new(sub_id: params[:sub_id], user_id: user.id)
    @sub = Sub.find_by_id(params[:sub_id])
    if @mod.save
      flash[:success] = ["Made new mod!"]
      redirect_to sub_url(@sub)
    else
      flash.nowMode[:errors] = @mod.errors.full_messages
      render :new
    end
  end

  private
  def mod_params
    params.require(:mod).permit(:username)
  end
end
