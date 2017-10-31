class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in?

  def current_user
    user = User.find_by_session_token(session[:session_token])
    user
  end

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    session[:session_token] = user.session_token
  end

  def log_out!
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def make_mod(sub)
    moderator = Moderator.new
    moderator.user_id = current_user.id
    moderator.sub_id = sub.id
    moderator.save
  end

  def ensure_logged_in
    redirect_to new_session_url if !logged_in?
  end

  def ensure_is_moderator
    sub = Sub.find_by_id(params[:sub_id])
    redirect_to sub_url(params[:sub_id]) if !sub.is_moderator?(current_user)
  end
end
