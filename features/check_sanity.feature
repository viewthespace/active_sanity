Feature: Check sanity

  As a developer
  In order to ensure that existing records are valid
  I want to run 'rake db:check_sanity' and see which records are invalid

  Background:
    Given I have a rails app with a Gemfile requiring 'active_sanity'

  Scenario: Check sanity on empty database
    When I run "rake db:check_sanity"
    Then I should see "Checking the following models: Category, Post, User"
    Then I should not see any invalid records

  Scenario: Check sanity on database with valid records
    Given the database contains a few valid records
    When I run "rake db:check_sanity"
    Then I should not see any invalid records

  Scenario: Check sanity on database with invalid records
    Given the database contains a few valid records
    And the first user's username is empty and the first post category_id is nil
    When I run "rake db:check_sanity --trace"
    Then I should see the following invalid records:
      | User     | 1 | {:username=>["can't be blank"]} |
      | Post     | 1 | {:category=>["can't be blank"]} |