class PasswordResetMailer < ActionMailer::Base
  default from: 'list.of.games.app@gmail.com'

  def reset_email(user)
    @user = user
    mail to: @user.email, subject: 'Password reset'
  end
end
