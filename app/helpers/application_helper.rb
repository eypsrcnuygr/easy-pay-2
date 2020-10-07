module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:author_id]) if session[:author_id]
  end

  def logged_in?
    current_user ? true : false
  end
end
