ruby "1.9.3"
source "http://rubygems.org"

gem "compass"
gem "haml"
gem "heroku-nav"
gem "rake"
gem "rdiscount", "~> 1.6.x"
gem "sass"
gem "sinatra"

group :development do
  gem "shotgun"
  gem "pg", "=0.13.2"
end

group :production do
  gem "rack-ssl-enforcer"
  gem "thin"
  gem "pg", "=0.13.2"
end

group :packaging do
  gem "fog"
end
