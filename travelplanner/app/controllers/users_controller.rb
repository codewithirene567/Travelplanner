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
            @user = User.create(name: params[:name], username: params[:username], password: params[:password])
              session[:user_id] = @user.id #this line lets them logged in
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
  #get "/login" do
  #  if !logged in?
  #    erb :'users/login'
  #  else
  #    redirect to '/'
  #  end
#  end
  #    erb :'/users/login'

  #  end

    get '/login' do
      @user = User.find_by(id: params[:id])
      #if @user = session[:user_id]
        erb :"/users/login"

    #  else
    #    redirect '/'
      end
    

    post "/users/login" do
  #we want to find the user based on their paramas
     if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
     redirect to "/users/#{@user.id}"
      #else
    #  redirect to "/failure"
    end
    end

get "/user/:id" do
  erb :'/users/show'
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



  #  delete "/users/:id" do
  #    User.destroy(params[:id])
  #    redirect to "/plans/account"
  #  end

end
