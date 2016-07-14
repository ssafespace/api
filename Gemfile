source "https://rubygems.org"

ruby "2.3.0"

gem "rails", "5.0.0"

gem "puma", "3.0.0"

gem "pg", "0.18.4"

gem "redis", "3.0.0"

gem "que", "0.11.5"

gem "state_machines-activerecord", "0.4.0"

gem "bcrypt", "3.1.7"

gem "rack-cors", "0.4.0"

group :production do
  gem "postmark-rails", "0.12.0"
  gem "rails_12factor", "0.0.3"
end

group :development, :test do
  gem "byebug", "9.0.3", platform: :mri
  gem "figaro", "1.1.1"
end

group :development do
  gem "listen", "3.0.5"
  gem "letter_opener", "1.4.1"
end
