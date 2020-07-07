require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SECRET_PHRASE'] #switch back to this after local ENV['SESSION_SECRET']
  end #this was call your password from the env file, so that users cannot see it
  

  get '/' do #this line represents what happens when users navigate to the home page of the app
    erb :'/users/index' #this line displays the users/index erb file
  end

  helpers do #this is a helper method that defines what makes somebody logged in, in this case it is that the session number equals the user's id
    def logged_in?
      !!session[:user_id]
      #ensure we are getting a truthy value, turns it into it's opposite truthiness
      #turning it into a truthy value rather than it's actual value
    end
#NEW
    def authorize_to_edit(plan) #accept an object as an argument, plans
      #return true if the current user is the creator of the plan
      #otherwise false
      if !plan || plan.user != current_user
        redirect to '/plans'
      end
    end

    def current_user #this defines what a current user is, it is a user which is set to an instance varaiable equal to whenever the right session is found
      @user = User.find(session[:user_id])
    end

  end

private #it is a way to designate that this method can be used locally
#note: there is a lesson on it in ruby section

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
