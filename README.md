# Active Sanity

[![Build Status](https://secure.travis-ci.org/versapay/active_sanity.png)](http://travis-ci.org/versapay/active_sanity)

Perform a sanity check on your database through active record
validation.

## Requirements

* ActiveSanity ~0.2 requires Rails ~3.1
* ActiveSanity ~0.1 requires Rails ~3.0

## Install

Add the following line to your Gemfile

    gem 'active_sanity'

If you wish to store invalid records in your database run:

    $ rails generate active_sanity
    $ rake db:migrate

## Usage

Just run:

    rake db:check_sanity

ActiveSanity will iterate over every records of all your models to check
weither they're valid or not. It will save invalid records in the table
invalid_records if it exists and output all invalid records.

The output might look like the following:

    model       | id  | errors
    User        |   1 | { "email" => ["is invalid"] }
    Flight      | 123 | { "arrival_time" => ["can't be nil"], "departure_time" => ["is invalid"] }
    Flight      | 323 | { "arrival_time" => ["can't be nil"] }

## Contribute & Dev environment

Usual fork & pull request.

This gem is quite simple so I experiment using features only. To run the
acceptance test suite, just run:

    bundle install
    RAILS_ENV=test cucumber features

Using features only was kinda handsome until I had to deal with two
different database schema (with / without the table invalid_records) in
the same test suite. I guess that the same complexity would arise using
any other testing framework.
