class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  def isAdmin?
    current_user.email == 'admin@gmail.com' unless current_user.blank?
  end


end