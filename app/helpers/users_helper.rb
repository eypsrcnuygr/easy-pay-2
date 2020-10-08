module UsersHelper
  def user_logged_in?
    return unless logged_in?

    render 'buttons_for_logged_in_user'
  end
end
