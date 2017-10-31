class SubsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      make_mod(@sub)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find_by_id(params[:id])
    if @sub
      render :show
    else
      flash.now[:errors] = ["Sub doesn't exist yet"]
      render :new
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
