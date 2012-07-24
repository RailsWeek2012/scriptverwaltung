class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    store_return_url
  end

  def destroy
    #nur für admins
    redirect_to script_path
  end
end
