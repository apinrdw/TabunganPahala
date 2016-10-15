source 'https://rubygems.org'

# Core
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'puma'

# Databases
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Template engines
gem 'jbuilder', '~> 2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'slim-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'execjs', platforms: :ruby

# Assets
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass'

# Utils
gem 'simple_enum'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'benchmark_methods'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
