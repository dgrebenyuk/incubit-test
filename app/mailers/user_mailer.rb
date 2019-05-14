class UserMailer < ApplicationMailer
  default from: 'noreply@incubittest.com'
  layout 'mailer'

  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'Welcome to Incubit Test Site')
  end

  def reset_password
    @user = params[:user]
    @url = "http://localhost:3000/password/edit?token=#{@user.reset_password_token}"
    mail(to: @user.email, subject: 'Reset Password')
  end
end
