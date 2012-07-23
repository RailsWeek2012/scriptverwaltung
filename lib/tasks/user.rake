require File.expand_path('../../../config/environment.rb', __FILE__)


namespace :user do
  desc "switch attribute isadmin in last user "
  task :toggle_isadmin => :environment do
    User.last.toggle(:isAdmin).save
  end

  desc "Create a new user and change all authorizations of the last user . The old user still exists "
  task :new => :environment do
    old = User.last
    new = User.new
    new.username= old.username
    new.email=  old.email
    new.isAdmin= old.isAdmin?
    old.username= "old_#{old.username}"
    new.save
    old.authorizations.each do |auth|
      auth.user= new
      auth.save
    end
    puts "Logout to clean your session"
  end
end
