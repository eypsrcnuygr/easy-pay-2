module UsersHelper
  def buttons_for_user
    return unless logged_in?

    render 'buttons_for_logged_in_user'
  end

  def internal_transactions_exist?
    if @internal_transactions.length == 0
      render 'non_exist_internal_transactions'
    else
      render 'exist_internal_transactions'
    end
  end

  def external_transactions_exist?
    if @external_transactions.length == 0
      render 'non_exist_external_transactions'
    else
      render 'exist_external_transactions'
    end
  end

  def groups_exist?
    if @groups.length == 0
      render 'non_exist_groups'
    else
      render 'exist_groups'
    end

   
  end
end
