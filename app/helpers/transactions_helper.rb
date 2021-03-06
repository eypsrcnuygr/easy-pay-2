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
    if logged_in? && @transaction.author == current_user && !@transaction.new_record?
      render 'buttons_for_logged_user'
    elsif logged_in? && @transaction.new_record?
      render 'empty'
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

  def transaction_id_creator(obj)
    @obj = obj
    if obj.author == current_user
      render 'logged_in_buttons'
    else
      render 'not_logged_in_buttons'
    end
  end
end
