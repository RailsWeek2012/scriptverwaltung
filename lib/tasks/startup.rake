require File.expand_path('../../../config/environment.rb', __FILE__)

#desc Raketask to set up scriptverwaltung
task :startup => :environment do
  system "bundle"
  system "rake db:migrate"
  system "rake sunspot:solr:start"
  system "rake sunspot:reindex"
  puts "Scriptverwaltung is now ready"
  puts "Start server with \"rails s\""
  puts "Use \"rake user:toggle_isadmin\" to give the last user admin rights"
end
