require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "to_be_replaced"#switch back to this after local ENV['SESSION_SECRET']
  end

  get '/' do
    erb :'/other/layout'
  end

end
