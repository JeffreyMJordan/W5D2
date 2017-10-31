class UsersController < ApplicationController

  before_action :ensure_logged_in, only: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      flash[:success] = ["Created New User"]
      redirect_to new_user_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if @user.id == current_user.id

    else
      flash[:errors] = ["Stop trying to destroy users who aren't you"]
      redirect_to root_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
