class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :auth_token
  helper_method :current_user

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def log_in_user!(user)
    if user
      session[:session_token] = user.reset_session_token!
      user.save!
      flash[:notice] = ["Logged in!"]
      redirect_to :root
    else
      flash[:notice] = ["Log in failed!"]
      redirect_to new_session_url
    end
  end

  def block_logged_out_user
    redirect_to new_session_url unless current_user
  end

  def handle_logged_in_user
    redirect_to subs_url if current_user
  end

  def auth_token
    token = <<-HTML
      <input
        type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML

    token.html_safe
  end
end
