ENV['SINATRA_ENV'] ||= "development"
SINATRA_ACTIVESUPPORT_WARNING=false

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)
require 'securerandom'
require_all 'app'
