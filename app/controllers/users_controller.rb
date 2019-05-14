class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now
      session[:user_id] = @user.id
      redirect_to user_path, notice: t('alerts.sign_up')
    else
      render :new
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path, notice: t('alerts.user_update')
    else
      render :show
    end
  end

  def destroy
    current_user.destroy
    redirect_to users_url, notice: t('alerts.user_destroy')
  end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
    end
end
