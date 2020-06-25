class UsersController < ApplicationController
#new
    get "/signup" do
     @plans = Plan.all
     erb :'/users/signup'
    end


    post "/signup" do
      @user = User.create(params[:user])
      if !params["plan"]["plan_id"].empty?
        #wanted to see if this format was correct in this line?
        #doing 2 diffferent actions in one route, you are creating and signing up a person
        #but you are also creating a plan
        #both of those created actions need to have checks to make sure they were filled in correctly
        #suggested to move the following 3 lines into the plan class
        @user.plans << Plan.create(plan_id: params["plan"]["plan_id"],
        destination: params["destination"], mode_of_transport: params["mode_of_transport"],
        date: params["date"], user_id: @user.id)
#if there is a user_id then thery are logged in
#if@person!=nil && @person.password
#  session[:owner_id] = @person.id
# redirect to '/person/account'
      end
      redirect "/plans/new"
    end
#read
    get "/login" do

      @user = User.find(params[:id])

      erb :'/users/login'
    end

    post "/login" do
      @user = User.find(username: params[:id])
      if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/plans/account"
      else
      redirect to "/other/failure"
    end
    end

    get "/users/account" do
      @user = User.find(params[:id])
      erb :'/plans/account'
    end
#update
    get "/users/:id/edit" do
      @user = User.find(params[:id])
      @plans = Plan.all
      erb :'/users/edit'
    end

    patch "/users/:id" do
      @user = User.find(params[:id])
      @user.update(params[:person])

      if !params["plan"]["plan_id"].empty?
        @user.plans << Plan.create(plan_id: params["plan"]["plan_id"])
      end

      redirect "/users/#{@user.id}"
    end

    get "/other/failure" do
        erb :failure
      end

    get "/logout" do
      session.clear
      redirect "/"
    end
#destroy
    helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        User.find(session[:user_id])
      end
    end

    delete "/users/:id" do
      User.destroy(params[:id])
      redirect to "/plans/account"
    end

end
