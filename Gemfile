# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1', '>= 6.1.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11', '>= 2.11.2'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sass-rails', '~> 6.0'
gem 'sdoc', '~> 2.0', '>= 2.0.3'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'webrick', '~> 1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Call 'byebug' anywhere in the code to stop execution and
  # get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 4.1'
end

group :test do
  gem 'coveralls', require: false
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rake'
  gem 'rspec', '~> 3.10'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.2'
  gem 'rubocop', '~> 1.9', require: false
end
