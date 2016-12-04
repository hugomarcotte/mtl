class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  def index
    @users = User.all
  end

  def destroy
    @user.destroy

    flash.alert = 'User was successfully destroyed.'
    redirect_to admin_users_url
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User was updated!'
      render json: { :message => 'User updated successfully' }
    else
      flash[:error] = 'Oops! Something went wrong.'
      render json: { :errors => @user.errors.full_messages }, :status => :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:admin)
  end
end