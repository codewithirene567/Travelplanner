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
        @person.plans << Person.create(plan_id: params["plan"]["plan_id"])
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
    end

    delete "/persons/:id" do
    end

end
