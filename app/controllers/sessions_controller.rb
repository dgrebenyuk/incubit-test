# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to user_path if current_user
  end

  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path, notice: t('alerts.login')
    else
      flash.now[:alert] = t('alerts.invalid_credentials')
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('alerts.logout')
  end
end
