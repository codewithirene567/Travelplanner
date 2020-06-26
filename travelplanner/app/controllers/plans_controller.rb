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

    post '/plans' do
   @user = User.new
   @plan = Plan.find_by id:params["plan_id"]

    if !params["user"]["name"].empty?
      @plan.user = User.create(name: params["user"]["name"])
    end

    @plan.save

    redirect to "plans/#{@plan.id}"
  end

    #if !params["plan"]["plan_id"].empty?

      #doing 2 diffferent actions in one route, you are creating and signing up a person
      #but you are also creating a plan
      #both of those created actions need to have checks to make sure they were filled in correctly
      #suggested to move the following 3 lines into the plan class
      #@user.plans << Plan.create(plan_id: params["plan"]["plan_id"],
      #destination: params["destination"], mode_of_transport: params["mode_of_transport"],
      #date: params["date"], user_id: @user.id)
    #end
#read
    get "/plans/:id" do

      @user = User.new
      @plan = Plan.find_by id:params["plan_id"]

     #@username = (params[:id][:username])
      erb :'plans/new'
    end
    #end
#update
  #  get "/plans/:id/edit" do
  #    @plans = Plan.find(params[:id])
  #    erb :'/plans/edit'
  #  end

  #  get "/plans/:id" do
  #  @plan = Plan.find(params[:id])
  #  erb :'/plans/account'
#  end

  #  patch "/plans/:id" do
  #    @plan = Plan.find(params[:id])
  #    @plan.update(params[:user][:plan])
  # redirect to "/plan/#{ @plan.id }"
  #  end
#delete
  #  delete "/plans/:id" do
  #    Plan.destroy(params[:id])
  #    redirect to "/plans/account"
  #  end

end
