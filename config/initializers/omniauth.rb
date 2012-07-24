#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :identity, :fields => ['email','username']
#end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas, :host => 'cas.thm.de/cas', :ssl => true
  provider :identity, :fields => ['email','username']
end
