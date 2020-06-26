class PlansController < ApplicationController
#create
    get "/plans" do
      @plans = Plan.all
      erb :'/plans/index'
    end

    get "/plans/new" do
      @user = User.new
      #@plan = Plan.find_by id:params["plan_id"]

      erb :'/plans/new'
    end

    post '/plans' do #creates a new travel plan and posts it so they can see it
    #if you can't see it usually  wasn't created correctly
   @plan = Plan.create(name: params[:plan][:name],
   destination: params[:plan][:destination], mode_of_transport: params[:plan][:mode_of_transport],
   date: params[:plan][:date])

      @plan.user = current_user

    @plan.save
    redirect to "/plans/#{@plan.id}"
  end

#read
    get "/plans/:id" do
      #check_if_user_logged_in
      @plan = Plan.find(params[:id])
#the only thing that can get sent into find is an id
      erb :'/plans/show'
    end
    #end
#update
    get "/plans/:id/edit" do
      @plans = Plan.find(params[:id])
      erb :'/plans/edit'
    end

  #  patch "/plans/:id" do
  #    @plan = Plan.find(params[:id])
  #    @plan.update(params[:user][:plan])
  # redirect to "/plan/#{ @plan.id }"
  #  end
#delete

get "/failure" do
    erb :'/failure'
  end

    delete "/plans/:id" do
      Plan.destroy(params[:id])
      redirect to "/users/show"
    end

end
