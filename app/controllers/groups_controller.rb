# frozen_string_literal: true

require 'csv'

class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy update_user_role add_user_to_group]

  def index
    @groups = Group.all
    @organizers = @group.users.organizers if @group
  end

  def show
    @users = @group.users
    @user_group_associations = @group.user_group_associations
  end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @group.destroy
      flash[:notice] = 'Group was successfully destroyed.'
    else
      flash[:alert] = "Error destroying group: #{group.errors.full_messages.join(', ')}"
    end

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  def update_user_role
    @user = user(params[:user_id])
    role = params[:role]

    message = @group.update_user_role(@user, role)
    redirect_to @group, notice: message
  end

  def add_user_to_group
    user_id = params[:user_group_association][:user_id]

    if user_id.present? && !@group.user_ids.include?(user_id.to_i)
      @group.add_user_to_group(user(user_id))
      flash[:notice] = 'User added to the group successfully.'
    else
      flash[:alert] = 'Invalid user or user already in the group.'
    end

    redirect_to edit_group_path(@group)
  end

  private

  def user(user_id)
    User.find(user_id)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
