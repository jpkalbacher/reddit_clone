class SessionsController < ApplicationController
  before_action :handle_logged_in_user, except: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    log_in_user!(@user)
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to :root
  end
end
