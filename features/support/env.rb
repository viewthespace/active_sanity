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
  tables = ['users', 'categories', 'posts']
  conn = ActiveRecord::Base.connection
  tables << 'invalid_records' if conn.table_exists?('invalid_records')
  tables.each do |table|
    conn.execute("DELETE FROM '#{table}'")
    conn.execute("DELETE FROM sqlite_sequence WHERE name='#{table}'")
  end
end
