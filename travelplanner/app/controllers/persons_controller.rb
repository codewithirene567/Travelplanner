class PersonsController < ApplicationController
#new
    get "/persons/signup" do
     @plans = Plan.all
     erb :'/persons/new'
    end

    post "/persons/signup" do
      @person = Person.create(params[:person])
      if !params["plan"]["plan_id"].empty?
        @person.plans << Plan.create(plan_id: params["plan"]["plan_id"],
        destination: params["destination"], mode_of_transport: params["mode_of_transport"],
        date: params["date"], person_id: params["person_id"])

      end
      redirect "/owners/#{@person.id}"
    end
#read
    get "/persons/account" do
      @person = Person.find(params[:id])
      erb :'/persons/show'
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
