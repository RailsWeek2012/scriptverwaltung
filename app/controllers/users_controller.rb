class UsersController < ApplicationController
	before_filter :isAdmin?, :only => [:toggle_admin]
  def show
    @user = User.find(params[:id])
    store_return_url
  end

  def toggle_admin
  	User.find(params[:id]).toggle(:isAdmin).save
  	redirect_to show_user_path current_user
  end
end
