ruby "1.9.3"
source "http://rubygems.org"

gem "compass"
gem "haml"
gem "heroku-nav"
gem "rake"
gem "rdiscount", "~> 1.6.x"
gem "sass"
gem "sinatra"
gem "heroku-bouncer", "0.4.0.pre3", git: 'git://github.com/raul/heroku-bouncer', branch: 'skip-option'

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

group :packaging do
  gem "fog"
end
