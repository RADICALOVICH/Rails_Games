# frozen_string_literal: true

# Application
class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end

  def no_authentication
    return unless user_signed_in?

    flash[:warning] = t('global.no_authentication')
    redirect_to root_path
  end

  def authentication
    return if user_signed_in?

    flash[:warning] = t('global.authentication')
    redirect_to root_path
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete :user_id
  end
  helper_method :current_user, :user_signed_in?
end
