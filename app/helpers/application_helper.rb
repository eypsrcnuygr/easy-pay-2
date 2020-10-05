module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:author_id]) if session[:author_id] 
  end

  def logged_in?
    !!current_user
  end

  def current_transaction
    @current_transaction = current_user.transactions.last
  end

  def current_groups
    @current_groups = current_transaction.groups.last
  end
end
