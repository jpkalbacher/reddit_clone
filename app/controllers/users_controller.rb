class UsersController < ApplicationController
  before_action :handle_logged_in_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def edit
  end

  def update
  end

  def index

  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
