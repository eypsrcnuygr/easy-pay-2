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

  def icon_creator(obj)
    obj.groups.each do |group|
      if group.name == 'Music'
        group.icon = '<i class="fas fa-guitar"></i>'
      elsif group.name == 'Food'
        group.icon = '<i class="fas fa-hamburger"></i>'
      elsif group.name == 'Sport'
        group.icon = "<i class='fas fa-swimmer'></i>"
      elsif group.name == 'Rent'
        group.icon = '<i class="fas fa-house-user"></i>'
      else
        group.icon = '<i class="fas fa-comment"></i>'
      end
      puts group.icon
      return group.icon.html_safe
    end
  end
  
end
