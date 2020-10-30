ENV['SINATRA_ENV'] ||= "development"

require 'bundler'
Bundler.require(:default, ENV['SINATRA_ENV'])
# require 'dotenv/load'
Dotenv.load if ENV['SINATRA_ENV'] == "development"

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

set :database_file, "./database.yml"

require './app/controllers/application_controller.rb'
require_all 'app'
