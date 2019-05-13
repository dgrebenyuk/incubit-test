class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path, notice: 'User was successfully updated.'
    else
      render :show
    end
  end

  def destroy
    current_user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
    end
end
