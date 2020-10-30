require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SECRET_PHRASE'] 
  end
  

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

private

  def redirect_if_logged_out
    if !logged_in?
      redirect '/'
    end
  end

  def redirect_if_logged_in
    if logged_in?
      redirect '/users/show'
    end
  end


end
