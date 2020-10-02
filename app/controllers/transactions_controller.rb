class TransactionsController < ApplicationController
  include ApplicationHelper
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
    @user_transactions = current_user.transactions.includes(:groups) if current_user
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    @groups = @transaction.groups
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @group = Group.new
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions
  # POST /transactions.json
  def create

    @transaction = Transaction.new(transaction_params)
    @transaction.author = current_user

    @group = Group.find_by(name: params[:group][:name])
    @group.user = current_user
    @group.save

    @group.transactions << current_user.transactions


    respond_to do |format|
      if @transaction.save 
        @transaction.groups << @group
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:author_id, :name, :amount)
  end

  def group_params
    params.require(:group).permit(:name, :icon, :user_id)
  end
end
