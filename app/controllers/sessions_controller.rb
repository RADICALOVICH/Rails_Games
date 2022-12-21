class SessionsController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  before_action :authentication, only: :destroy
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      if user.email_confirmed
        sign_in(user)
        flash[:success] = "С возвращением, #{current_user.name}"
        redirect_to root_path
      else
        flash[:error] = 'Пожалуйста, активируйте свою учетную запись, следуя
        инструкции в электронном письме с подтверждением учетной записи'
        redirect_to new_session_path
      end
    else
      flash[:warning] = 'Ошибка в вводе почты и/или пароля'
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash[:success] = 'Ждем вас снова!'
    redirect_to root_path
  end
end
