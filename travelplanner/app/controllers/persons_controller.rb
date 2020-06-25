class PersonsController < ApplicationController
#new
    get "/signup" do
     @plans = Plan.all
     erb :'/persons/signup'
    end


    post "/signup" do
      @person = Person.create(params[:person])
      if !params["plan"]["plan_id"].empty?
        #wanted to see if this format was correct in this line?
        #doing 2 diffferent actions in one route, you are creating and signing up a person
        #but you are also creating a plan
        #both of those created actions need to have checks to make sure they were filled in correctly
        #suggested to move the following 3 lines into the plan class
        @person.plans << Plan.create(plan_id: params["plan"]["plan_id"],
        destination: params["destination"], mode_of_transport: params["mode_of_transport"],
        date: params["date"], person_id: @person.id)
#if there is a user_id then thery are logged in
#if@person!=nil && @person.password
#  session[:owner_id] = @person.id
# redirect to '/person/account'
      end
      redirect "/plans/new"
    end
#read
    get "/login" do
    
      @person = Person.find(params[:id])

      erb :'/persons/login'
    end

    post "/login" do
      @person = Person.find(username: params[:id])
      if @person && @person.authenticate(params[:password])
      session[:person_id] = @person.id
      redirect to "/plans/account"
      else
      redirect to "/other/failure"
    end
    end

    get "/persons/account" do
      @person = Person.find(params[:id])
      erb :'/plans/account'
    end
#update
    get "/persons/:id/edit" do
      @person = Person.find(params[:id])
      @plans = Plan.all
      erb :'/persons/edit'
    end

    patch "/persons/:id" do
      @person = Person.find(params[:id])
      @person.update(params[:person])

      if !params["plan"]["plan_id"].empty?
        @person.plans << Plan.create(plan_id: params["plan"]["plan_id"])
      end

      redirect "/persons/#{@person.id}"
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
        Person.find(session[:user_id])
      end
    end

    delete "/persons/:id" do
      Person.destroy(params[:id])
      redirect to "/plans/account"
    end

end
