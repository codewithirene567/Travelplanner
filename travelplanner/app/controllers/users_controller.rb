
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
      #redirect '/failure'
      redirect '/signup'

  #if logged_in?
  #  redirect to '/plans'
  #elsif params[:username] == "" || params[:password] == ""
  #      redirect '/failure'
  #else
  #  @user = User.create(name: params[:name], username: params[:username], password: params[:password])
  #  @user.save
    #session[:user_id] = @user.id #this line lets them logged in
  #  redirect '/plans'
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
    #we want to find the user based on their paramas
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
