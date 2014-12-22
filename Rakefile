require 'bundler'
Bundler::GemHelper.install_tasks

task default: :features

desc 'Run features'
task :features do
  fail 'Failed!' unless system('export RAILS_ENV=test && bundle exec cucumber features')
end

desc 'Clean test rails app'
task :clean do
  puts 'test/rails_app deleted successfully' if system('rm -r test/rails_app')
end
