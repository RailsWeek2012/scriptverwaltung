#Encoding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    #Nachschlagen ob schon eine User mit dieser uid und provider angelegt ist
    #Überprüfen ob der User bereits eingeloggt ist
    if session[:user_id]
      User.find(session[:user_id]).add_new_provider auth_hash
      redirect_to scripts_path, notice: "Ihr Konto des Services #{auth_hash["provider"]} wurde verknüpft."
    else
      #einloggen
      user = User.findOrCreateNewUserWithProvider auth_hash
      session[:user_id] = user.id
      redirect_to scripts_path, notice: "Sie haben sich angemeldet"
    end
  end

  def failure
    redirect_to login_path, alert: "Ihre Anmeldung ist fehlgeschlagen. Versuchen Sie es erneut."
    #render action: "new"
  end
  def destroy
    session[:user_id] = nil
    redirect_to scripts_path,
                notice: "Sie haben sich abgemeldet."
  end
end
