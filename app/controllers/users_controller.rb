class UsersController < ApplicationController
	before_filter :admin?, :only => [ :toggle_admin ]
  before_filter :require_login!, :except => [ :show ]
  def show
    @user = User.find(params[:id])
    store_return_url
  end

  def toggle_admin
  	User.find(params[:id]).toggle(:isAdmin).save
  	redirect_to show_user_path(current_user)
  end

  private
    def admin?
      unless isAdmin?
        redirect_to scripts_path, alert: "Sie haben keine Berechtigung zum Aufruf dieser Ressource "
      end
    end
end
