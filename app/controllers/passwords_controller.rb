# frozen_string_literal: true

class PasswordsController < ApplicationController
  def create
    user = User.where(email: user_params[:email]).first

    if user
      user.generate_password_token! # generate pass token
      redirect_to root_path, notice: t('alerts.reset_instructions')
    else
      flash.now[:alert] = t('alerts.no_user', email: user_params[:email])
      render :new
    end
  end

  def edit
    @user = User.where('reset_password_token=? AND reset_password_sent_at > ?',
                       params[:token], 6.hours.ago).first
    invalid_token && return unless @user
  end

  def update
    @user = User.where('reset_password_token=? AND reset_password_sent_at > ?',
                       user_params[:reset_password_token], 6.hours.ago).first
    invalid_token && return unless @user

    if @user.update(user_params)
      redirect_to root_path, notice: t('alerts.success_reset')
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :reset_password_token,
                                 :password, :password_confirmation)
  end

  def invalid_token
    redirect_to root_path,
                flash: { error: t('alerts.invalid_token') }
  end
end
