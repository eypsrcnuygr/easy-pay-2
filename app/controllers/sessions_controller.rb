class SessionsController < ApplicationController
  def new; end

  def create
    find_or_create_user

    if @user && @user.provider.nil? && @user.authenticate(params[:session][:password])
      session[:author_id] = @user.id
      flash[:notice] = 'Logged in succesfuly'
      redirect_to user_path(@user)
    elsif @user && !@user.provider.nil?
      session[:author_id] = @user.id
      flash[:notice] = 'Logged in succesfuly'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = 'There was something wrong with your login information'
      render 'new'
    end
  end

  def destroy
    session[:author_id] = nil
    flash[:notice] = 'logged out'
    redirect_to root_path
  end

  private

  def omniauth_hash
    request.env['omniauth.auth']
  end

  def find_or_create_user
    @user = if omniauth_hash.nil?
              User.find_by(name: params[:session][:name].downcase)
            else
              User.from_omniauth(omniauth_hash)
            end
    @user
  end
end
