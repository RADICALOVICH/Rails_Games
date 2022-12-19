class UsersController < ApplicationController

  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}"
      redirect_to root_path
    else
      redirect_to new_user_path, notice: 'Ошибка во вводе данных или такой пользователь уже существует'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Данные обновлены'
      redirect_to root_path
    else
      flash[:warning] = 'Значения полей не могут быть пустыми'
      redirect_to edit_user_path
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
