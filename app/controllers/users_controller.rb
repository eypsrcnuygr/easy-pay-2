class UsersController < ApplicationController
  include ApplicationHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @current_user = current_user
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @internal_transactions = current_user.transactions.where(transaction_status: true)
    @external_transactions = current_user.transactions.where(transaction_status: false)
    @groups = Group.select(:name).distinct

    @icons = []
    @external_transactions.each do |transaction|
      transaction.groups.each do |group|
        @icons << group.icon
      end
    end

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:author_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' } if logged_in?
        format.json { render :show, status: :created, location: @user } if logged_in?

      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :password)
    end
end
