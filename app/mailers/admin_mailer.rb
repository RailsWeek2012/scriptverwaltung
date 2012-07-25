class AdminMailer < ActionMailer::Base
  default from: "scriptverwaltung@web.de"


  def notification_email(user, script, fullurl)
    @user = user
    @script = script
    @fullurl  = fullurl
    mail(:to => user.email, subject: "Es steht ein neues Script zum freischalten bereit")
  end
end
