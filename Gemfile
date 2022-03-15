# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").chomp

gem "rails", "7.0.2.3"

gem "bootsnap", require: false
gem "httparty"
gem "importmap-rails"
gem "jbuilder"
gem "nokogiri"
gem "pg"
gem "puma"
gem "redis"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop-govuk"
end

group :development do
  gem "rubocop", require: false
  gem "web-console"
end

group :test do
  gem "brakeman"
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "simplecov-rcov", require: false
  gem "webdrivers"
  gem "webmock", require: false
end
