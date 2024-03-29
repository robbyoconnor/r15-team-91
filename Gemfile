source 'https://rubygems.org'

ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Templating
gem 'slim-rails'
# Twitter bootstrap
gem 'bootstrap-sass'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Github API
gem 'octokit', '~> 4.0'

# Attributes with steroids (:
gem 'virtus'

# Use Unicorn as the app server
gem 'puma'

# Background processing
gem 'sidekiq'

# Log visualization improvements
gem 'lograge'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Environment variables
  gem 'dotenv-rails'

  # Better Rails Console
  gem 'pry-rails'
  gem 'awesome_print'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  # Specs
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'factory_girl_rails'

  # Test coverage
  gem 'codeclimate-test-reporter', group: :test, require: nil
end

group :production do
  # The twelve-factor app
  gem 'rails_12factor'

  # Cache store
  gem 'redis-rails'
end
