class User < ActiveRecord::Base
  attr_accessible :email, :username

  has_many :authorizations
  has_many :scripts
  has_many :comments

  validates :username, :email, presence: true

  def add_new_provider auth_hash
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create user: self, provider: auth_hash["provider"], uid: auth_hash["uid"]
    end
  end

  def self.findOrCreateNewUserWithProvider auth_hash
    auth = Authorization.find_by_uid_and_provider(auth_hash['uid'],auth_hash['provider'])
    if auth
      #gefunden
      return auth.user
    else
      #neu anlegen da noch nie eingeloggt
      if auth_hash['provider']['cas']
        user = User.new username: auth_hash["extra"]["user"], email: auth_hash["extra"]["attributes"][0]["mail"]
      elsif auth_hash['provider']['identity']
        user = User.new username: Identity.find(auth_hash["uid"]).username, email: auth_hash["info"]["email"]
      end
      user.add_new_provider auth_hash
      user.save
      user
    end
  end
end
