class UsersController < ApplicationController
#new
    get "/signup" do
     #@plans = Plan.all
     erb :'/users/signup'
    end


    post "/signup" do
      if params[:username] == "" || params[:password] == ""
            redirect '/failure'
          else
            User.create(name: params[:name], username: params[:username], password: params[:password])
             #binding.pry
            redirect '/plans/new'
          end
        end

        #get '/account' do
          #  @user = User.find(session[:user_id])
        #    erb :'plans/account'
          #end
    #  @user = User.create(params[:user])
      #if there is a user_id then thery are logged in
    #if @user!=nil && @user.password
    #  session[:user_id] = @user.id
    #  redirect to '/account'
    #end
    #redirect "/account"
    #end
#read
    get "/login" do

     #@user = User.find(params[:id])

     #@username = User.find(username: params[:id][:username])

      erb :'/users/login'

    end

    get '/users/login' do
      @user = User.find_by(id: params[:id])
      if @user
        erb :"/plans/show"

      else
        redirect '/'
      end
    end

    post "/users/login" do
     @user = User.create(username: params[:id])

     @username = User.create(username: params[:id][:username])
     if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
     redirect to "/users/login"
      else
      redirect to "/other/failure"
    end
    end

  #  get "/account" do
  #    @user = User.find(params[:id])
  #    erb :'/plans/account'
  #  end
#update
  #  get "/users/:id/edit" do
  #    @user = User.find(params[:id])
  #    @plans = Plan.all
  #    erb :'/users/edit'
  #  end

  #  patch "/users/:id" do
  #    @user = User.find(params[:id])
  #    @user.update(params[:person])

  #    if !params["plan"]["plan_id"].empty?
  #      @user.plans << Plan.create(plan_id: params["plan"]["plan_id"])
  #    end

  #    redirect "/users/#{@user.id}"
  #  end



    get "/logout" do
      session.clear
      redirect "/"
    end
#destroy
    #helpers do
    #  def logged_in?
    #    !!session[:user_id]
    #  end

    #  def current_user
    #    User.find(session[:user_id])
    #  end


  #  delete "/users/:id" do
  #    User.destroy(params[:id])
  #    redirect to "/plans/account"
  #  end

end
