ruby "1.9.3"
source "http://rubygems.org"

gem "compass"
gem "haml"
gem "heroku-nav"
gem "rake"
gem "rdiscount", "~> 1.6.x"
gem "sass"
gem "sinatra"
gem "heroku-bouncer", "0.4.1"

group :development do
  gem "shotgun"
end

group :production do
  gem "rack-ssl-enforcer"
  gem "thin"
end

group :development, :production do
  gem "pg", "=0.13.2"
  gem "honeybadger"
end

group :test do
  gem "rack-test"
  gem "minitest-spec-context"
  gem "mocha"
end

group :packaging do
  gem "fog"
end
