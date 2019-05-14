class PasswordsController < ApplicationController
  def create
    user = User.where(email: user_params[:email]).first

    if user
      user.generate_password_token! #generate pass token
      UserMailer.with(user: user).reset_password.deliver_now
      flash[:notice] = t('alerts.reset_instructions')

      redirect_to root_path
    else
      flash.now[:alert] = t('alerts.no_user', email: user_params[:email])
      render :new
    end
  end

  def edit
    @user = User.where('reset_password_token = ? and reset_password_sent_at > ?', params[:token], 6.hours.ago).first
    unless @user
      flash[:error] = t('alerts.invalid_token')
      redirect_to root_path
    end
  end

  def update
    @user = User.where('reset_password_token = ? and reset_password_sent_at > ?', user_params[:reset_password_token], 6.hours.ago).first
    unless @user
      flash[:error] = t('alerts.invalid_token')
      redirect_to root_path and return
    end

    if @user.update(user_params)
      redirect_to root_path, notice: t('alerts.success_reset')
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :reset_password_token, :password, :password_confirmation)
  end
end
