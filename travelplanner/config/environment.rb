ENV['SINATRA_ENV'] ||= "development"

require 'bundler'
Bundler.require
require 'dotenv/load'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './app/controllers/application_controller.rb'
require_all 'app'
