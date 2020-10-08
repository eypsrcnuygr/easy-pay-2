module TransactionsHelper
  def logged_in_transactions?
    if logged_in?
      render 'logged_in_transactions'
    else
      render 'not_authorized'
    end
  end

  def logged_in_show?
    if logged_in?
      render 'logged_in_show'
    else
      render 'not_authorized'
    end
  end

  def buttons_for_logged_user?
    if logged_in?
      render 'buttons_for_logged_user'
    else
      render 'not_authorized'
    end
  end

  def logged_in_edit?
    if logged_in?
      render 'logged_in_edit'
    else
      render 'not_authorized'
    end
  end
end
