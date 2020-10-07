class GroupsController < ApplicationController
  include ApplicationHelper
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = Group.all.group('groups.id').group(:name).includes(:user).order('created_at DESC')
  end

  def show
    @groups = Group.distinct(:name).where(name: @group.name).includes(:group_transactions, :transactions, :user)
  end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)
    @group.transactions << current_user.transactions.last if current_user.transactions.nil?
    @group.user = current_user
    @icon_array = []
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :icon, :user_id)
  end
end
