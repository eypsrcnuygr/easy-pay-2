module UsersHelper
  def buttons_for_user
    return unless logged_in?

    render 'buttons_for_logged_in_user'
  end

  def internal_transactions_exist?
    if @internal_transactions.length.zero?
      render 'non_exist_internal_transactions'
    else
      render 'exist_internal_transactions'
    end
  end

  def external_transactions_exist?
    if @external_transactions.length.zero?
      render 'non_exist_external_transactions'
    else
      render 'exist_external_transactions'
    end
  end

  def groups_exist?
    if @groups.length.zero?
      render 'non_exist_groups'
    else
      render 'exist_groups'
    end
  end

  def logged_in_index?
    if logged_in?
      render 'logged_in_index'
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

  def logged_in_edit?
    if logged_in?
      render 'logged_in_edit'
    else
      render 'not_authorized'
    end
  end
end
