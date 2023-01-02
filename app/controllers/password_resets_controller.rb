# frozen_string_literal: true

# Password_reset
class PasswordResetsController < ApplicationController
  before_action :no_authentication
  before_action :check_user_params, only: %i[edit update]
  before_action :set_user, only: %i[edit update]

  def create
    @user = User.find_by email: params[:email]
    if @user.present?
      @user.set_password_reset_token

      PasswordResetMailer.reset_email(@user).deliver_later
    end

    flash[:success] = t('.success')
    redirect_to root_path
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t('.success')
      redirect_to new_session_path
    else
      flash[:warning] = t('.warning')
      redirect_to password_reset_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(admin_edit: true)
  end

  def check_user_params
    redirect_to(new_session_path, flash: { warning: t('.warning') }) if params[:user].blank?
  end

  def set_user
    @user = User.find_by email: params[:user][:email],
                         password_reset_token: params[:user][:password_reset_token]
    redirect_to(new_session_path, flash: { warning: t('.warning') }) unless @user&.password_reset_period_valid?
  end
end
