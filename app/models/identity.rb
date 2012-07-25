class Identity < OmniAuth::Identity::Models::ActiveRecord
  has_secure_password
    attr_accessible :email,:username, :password_digest, :password, :password_confirmation

  validates :email,
          format: /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i,
          uniqueness: true
  validate :username,
           presence: true,
           uniqueness: true
end
