require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :features

desc "Run features"
task :features do
  raise "Failed!" unless system('bundle exec cucumber features')
end

desc "Clean test rails app"
task :clean do
  if system('rm -r test/rails_app')
    puts "test/rails_app deleted successfully"
  end
end
