# frozen_string_literal: true

# Session
class SessionsController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  before_action :authentication, only: :destroy
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      email_confirmed(user)
    else
      flash[:warning] = t('.warning')
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash[:success] = t('.success')
    redirect_to root_path
  end

  private

  def email_confirmed(user)
    if user.email_confirmed
      sign_in(user)
      flash[:success] = "#{t('.success')} #{current_user.name}"
      redirect_to root_path
    else
      flash[:error] = t('.error')
      redirect_to new_session_path
    end
  end
end
