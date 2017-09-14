class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def check_user_logged_in
    redirect_to new_user_session_path, :flash => {:error => 'You need to login before you do that'} unless user_signed_in?
  end

  def check_admin
    redirect_to root_path, :flash => {:error => 'You are not authorized for this'} unless user_signed_in? && current_user.admin?
  end
end
