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
    def require_login!
      unless user_signed_in?
        redirect_to login_path, alert: "Bitte melden Sie sich zuerst an."
      end
    end

    def only_owner!
      @script = Script.find(params[:id])
      unless isOwner?(@script) or isAdmin?
        redirect_to scripts_path, alert: "Sie haben keine Berechtigung die Ressource zu ändern"
      end
    end

    def isVisible?
      @script = Script.find(params[:id])
      unless current_user == @script.user or isAdmin? or isActiv?(@script)
        redirect_to scripts_path, alert: "Sie haben keine Berechtigung zum Aufruf dieser Ressource "
      end
    end

    def isOwner? script
      current_user.eql? script.user
    end

    def isActiv? script
      script.activated
    end

    def redirect_back_or_default(default)
      session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(default)
      session[:return_to] = nil
    end

    def store_return_url
      if request.get?
         session[:return_to] = request.env["REQUEST_URI"]
      else
        session[:return_to] = request.referer
      end
    end

  helper_method :isActiv?, :isOwner?, :user_signed_in?, :current_user, :redirect_guest_to_login, :isAdmin?, :require_login!, :only_owner!
end
