class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(name: params[:session][:name].downcase)

    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in succesfuly'
      redirect_to user_path(user)
    else
      flash.now[:alert] = 'There was something wrong with your login information'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'logged out'
    redirect_to root_path
  end
end
