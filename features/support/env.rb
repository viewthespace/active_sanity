ENV['BUNDLE_GEMFILE'] = File.expand_path('../../../Gemfile', __FILE__)

require 'rubygems'
require "bundler"
Bundler.setup

if File.directory?("test/rails_app")
  Dir.chdir("test/rails_app") do
    raise unless system("rm -f db/migrate/*create_invalid_records.rb && rake db:migrate:reset")
  end
end

After do
  # Reset DB!
  User.delete_all if 
  Category.delete_all
  Post.delete_all
  InvalidRecord.delete_all if InvalidRecord.table_exists?
  %w(users categories posts invalid_records).each do |table|
    ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='#{table}'")
  end
end
