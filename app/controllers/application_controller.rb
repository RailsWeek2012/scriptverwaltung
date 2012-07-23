#Encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  private
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end

    def user_signed_in?
      current_user.present?
    end

    def isAdmin?
     if current_user
        @current_user.isAdmin?
      else
        false
      end
    end

    def redirect_guest_to_login
      unless user_signed_in?
        redirect_to login_path, alert: "Sie müssen sich einloggen um diese Funktion zu benutzen"
        true
      else
        false
      end
    end

  helper_method :user_signed_in?, :current_user, :redirect_guest_to_login, :isAdmin?
end
