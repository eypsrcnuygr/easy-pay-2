class TransactionsController < ApplicationController
  include ApplicationHelper
  before_action :set_transaction, only: %i[show edit update destroy]
  helper_method :icon_creator

  # GET /transactions
  # GET /transactions.json
  def index
    @user_transactions = current_user.transactions.order('created_at DESC') if current_user
    @total_amount = @user_transactions.sum(:amount) if @user_transactions
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
    @transaction = Transaction.new(transaction_params.except(:groups))
    @transaction.author = current_user
    @groups = Group.all

    if transaction_params[:groups].length == 1
      @transaction.transaction_status = false
    else
      @transaction.transaction_status = true
    end

    respond_to do |format|
      if @transaction.save
        transaction_params.slice(:groups).values.each do |x|
          x.each do |y|
            if y.empty?
            else
              group = @groups.find(y.to_i)
              @transaction.groups << group
            end
          end
        end


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

  def assigned_transactions
    @transactions = []
    current_user.transactions.each do |transaction|
      @transactions << transaction if transaction.transaction_status == true
    end
  end

  def unassigned_transactions
    @transactions = []
    current_user.transactions.each do |transaction|
      @transactions << transaction if transaction.transaction_status == false
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:author_id, :name, :amount, groups: [], transaction_status: false)
  end

  def group_params
    params.require(:group).permit(:name, :icon, :user_id)
  end
end
