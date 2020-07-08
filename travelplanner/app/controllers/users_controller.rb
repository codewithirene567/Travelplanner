
class UsersController < ApplicationController

  get "/signup" do
   erb :'/users/signup'
  end

  post "/signup" do
   @user = User.create(name: params[:name], username: params[:username], password: params[:password])
    if @user.save #if everything goes right with the validations and it can save it
    session[:user_id] = @user.id
    redirect '/users/show'
    else
      redirect '/signup'
    end
  end

  get '/users/show' do
    @user = current_user
    @plans = @user.plans.all
    erb :'/users/show'
  end

  get '/login' do
     if logged_in?
       redirect '/plans'
     else
      erb :'/users/login'
    end
  end


  post '/users/login' do
    @user = User.find_by(username: params[:username]) #find the user by username
      if @user && @user.authenticate(params[:password]) #check if password matches
        session[:user_id] = @user.id
      @plans = @user.plans
      redirect "/users/show"
      else
        redirect '/wrongpassword'
      end
  end

  get '/wrongpassword' do
    erb :'/wrongpassword'
  end


  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect '/'
    end
  end

end
