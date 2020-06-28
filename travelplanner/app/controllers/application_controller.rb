require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SECRET_PHRASE'] #switch back to this after local ENV['SESSION_SECRET']
  end #this was call your password from the env file, so that users cannot see it

  get '/' do
    erb :'/users/index'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find(session[:user_id])
    end
  end


  def redirect_if_logged_out(session)
    if !logged_in?(session)
      redirect '/'
    end
  end

  def redirect_if_logged_in(session)
    if logged_in?(session)
      redirect '/users/show'
    end
  end


end
