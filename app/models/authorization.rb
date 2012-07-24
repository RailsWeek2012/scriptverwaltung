class Authorization < ActiveRecord::Base
  attr_accessible :user, :provider, :uid
  belongs_to :user
  validates :provider, :uid, presence: true
end
