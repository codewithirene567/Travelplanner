class PersonsController < ApplicationController

    get "/persons" do
      @persons = Person.all
      erb :'/persons/index'
    end

    get "/persons/new" do
     @plans = Plan.all
     erb :'/persons/new'
    end

    post "/persons" do
      @person = Person.create(params[:person])
      if !params["plan"]["plan_id"].empty?
        @person.plans << Plan.create(plan_id: params["plan"]["plan_id"],
        destination: params["destination"], mode_of_transport: params["mode_of_transport"],
        date: params["date"], person_id: params["person_id"])

      end
      redirect "/owners/#{@person.id}"
    end

    get "/persons/:id" do
      @person = Person.find(params[:id])
      erb :'/persons/show'
    end

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


    delete "/persons/:id" do
    end

end
