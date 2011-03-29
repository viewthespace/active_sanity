Given /^I have a rails app with a Gemfile requiring 'active_sanity'$/ do
  unless File.directory?("test/rails_app")
    unless system "bundle exec rails new test/rails_app -m test/rails_template.rb"
      system("rm -fr test/rails_app")
      raise "Failed to generate test/rails_app"
    end
  end
end

def rails_run(cmd)
  raise unless system("cd test/rails_app && rails runner '#{cmd.gsub("'", "\'")}'")
end

Given /^the database contains a few valid records$/ do
  rails_run(%{
    User.create!(:first_name => "Greg", :last_name => "Bell", :username => "gregbell")
    User.create!(:first_name => "Sam",  :last_name => "Vincent", :username => "samvincent")
    Category.create!(:name => "Uncategorized")
    Post.create!(:author => User.first, :category => Category.first,
      :title => "How ActiveAdmin changed the world", :body => "Only gods knows how...",
      :published_at => 4.years.from_now)
  })
end

Given /^the first user's username is empty and the first post category_id is nil$/ do
  rails_run %{User.first.update_attribute(:username, ""); Post.first.update_attribute(:category_id, nil)}
end


When /^I run "([^"]*)"$/ do |command|
  puts @output = `cd ./test/rails_app && #{command}; echo "RETURN:$?"`
  raise unless @output['RETURN:0']
end


Then /^I should see the following invalid records:$/ do |table|
  table.raw.each do |model, id, error|
    @output.should =~ /#{model}\s+\|\s+#{id}\s+\|\s+#{Regexp.escape error}/
  end
end

Then /^I should see "([^"]*)"$/ do |output|
  @output.should include(output)
end

Then /^I should not see any invalid records$/ do
  @output.should_not include('|')
end

Then /^the table "([^"]*)" should be empty$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the table "([^"]*)" should contain:$/ do |arg1, table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Given /^the first user's username is "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^the first post category is set$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^the first post title is empty$/ do
  pending # express the regexp above with the code you wish you had
end
