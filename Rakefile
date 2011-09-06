require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :features

task :features do
  raise "Failed!" unless system('bundle exec cucumber features')
end
