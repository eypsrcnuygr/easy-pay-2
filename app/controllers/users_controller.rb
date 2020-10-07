class UsersController < ApplicationController
  include ApplicationHelper
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
    @current_user = current_user
  end

  def show
    @internal_transactions = current_user.transactions.where(transaction_status: true)
    @external_transactions = current_user.transactions.where(transaction_status: false)
    @groups = Group.all.select(:name, :id, :icon).group('groups.id').group(:name).where(user_id: session[:author_id])
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:author_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' } if logged_in?
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    session[:author_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, provider: nil)
  end
end
