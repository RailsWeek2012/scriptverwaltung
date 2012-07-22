class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def destroy
    #nur für admins
    redirect_to script_path
  end
end
