source 'https://rubygems.org'

ruby '2.3.1'

gem 'puma'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7'
gem 'pg', '~> 0.15'

gem 'bcrypt', '~> 3.1.7'         # Use ActiveModel has_secure_password
gem 'aasm'
gem 'pundit'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'haml-rails', '~> 0.9'
gem 'simple_form'
gem 'carrierwave', '~> 0.11'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-sass', '~> 4.6.2'
gem 'turbolinks'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'better_errors'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers'
  gem 'pundit-matchers', '~> 1.1.0'
  gem 'capybara'
end

gem 'faker'
gem 'factory_girl_rails'
gem 'database_cleaner'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: nil
  gem 'rails_best_practices', require: false
  gem 'rubycritic', require: false
  gem 'rubocop', require: false
end

gem 'rails_12factor', group: :production
