module GroupsHelper
  def logged_in_index?
    if logged_in?
      render 'logged_in_index'
    else
      render 'not_authorized'
    end
  end

  def current_user_groups?
    if @group.user == current_user
      render 'current_user_buttons'
    else
      render 'back_button'
    end
  end

  def groups_show?
    if logged_in?
      render 'logged_in_show'
    else
      render 'not_authorized'
    end
  end

  def logged_in_new?
    if logged_in?
      render 'logged_in_new'
    else
      render 'not_authorized'
    end
  end

  def logged_in_edit?
    if logged_in? && @group.user == current_user
      render 'logged_in_edit'
    else
      render 'not_authorized'
    end
  end

  def group_id_creator(obj)
    @obj = obj
    if obj.user == current_user
      render 'logged_in_buttons'
    else
      render 'not_logged_in_buttons'
    end
  end
end
