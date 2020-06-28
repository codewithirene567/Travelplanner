
class UsersController < ApplicationController
#new
  get "/signup" do
   erb :'/users/signup'
  end

  post "/signup" do
   @user = User.create(name: params[:name], username: params[:username], password: params[:password])
    if @user.save #if everything goes right with the validations and it can save it
    session[:user_id] = @user.id
    redirect '/users/show'
    else
      redirect '/failure'

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
          @plans = @user.plans.all          #    @user = User.find(params[:id])
          erb :'/users/show'
        end

      #  if @user.save
      #    session[:user_id] = user.id
      #    redirect '/users/show'
      #  else
      #    redirect '/failure'
      #  end


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
   #redirect to "/users/#{@user.id}"
   #redirect '/plans'
   @plans = @user.plans.all
   erb :"/users/show"
   else
     redirect '/wrongpassword'
   end
  end

  get '/wrongpassword' do
    erb :'/wrongpassword'
  end

  get "/user/:id" do
    erb :'/users/show'
  end

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
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect '/'
    end
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
