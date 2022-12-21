class UsersController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  before_action :authentication, only: %i[edit update]
  before_action :set_user, only: %i[edit update]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver_later
      flash[:success] = 'Подтвердите вашу почту в отправленном письме.'
      redirect_to root_path
    else
      redirect_to new_user_path, notice: 'Ошибка во вводе данных или такой пользователь уже существует'
    end
  end

  def edit; end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Данные обновлены'
      redirect_to root_path
    else
      flash[:warning] = 'Значения полей не могут быть пустыми'
      redirect_to edit_user_path
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = 'Регистрация прошла успешно'
      redirect_to new_session_path
    else
      flash[:error] = 'Такого пользователя не существует'
      redirect_to root_url
    end
  end
  private

  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :old_password)
  end
end
