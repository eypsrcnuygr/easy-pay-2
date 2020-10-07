class TransactionsController < ApplicationController
  include ApplicationHelper
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    if current_user
      @user_transactions = current_user.transactions.order('created_at DESC')
        .includes(:author, :group_transactions, :groups)
    end
    @total_amount = @user_transactions.distinct(:name).sum(:amount) if @user_transactions
  end

  def show
    @groups = @transaction.groups
  end

  def new
    @transaction = Transaction.new
    @group = Group.new
  end

  def edit; end

  def create
    @transaction = Transaction.new(transaction_params.except(:groups))
    @transaction.author = current_user
    @groups = Group.all

    @transaction.transaction_status = transaction_params[:groups].length != 1

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
      else
        format.html { render :new }
      end
    end
  end

  def update
    @transaction.author = current_user
    @transaction.groups.clear
    @array = []
    @transaction.transaction_status = transaction_params[:groups].length != 1
    respond_to do |format|
      transaction_params.slice(:groups).values.each do |x|
        x.each do |y|
          if y.empty?
          else
            @array << y.to_i
          end
        end
        @transaction.groups << Group.find(@array)
      end
      if @transaction.update(transaction_params.except(:groups))

        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
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

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:author_id, :name, :amount, groups: [], transaction_status: false)
  end

  def group_params
    params.require(:group).permit(:name, :icon, :user_id)
  end
end
