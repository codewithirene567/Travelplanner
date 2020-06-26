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
   @plan = Plan.create(name: params[:name],
   destination: params[:destination], mode_of_transport: params[:mode_of_transport],
   date: params[:date])
#is this formatted correctly logic wise in the if statement
    if !params[:username] == "" || params[:password] == ""

      @plan.user = User.create(name: params[:name],
      destination: params[:destination], mode_of_transport: params[:mode_of_transport],
     date: params[:date])

    #else
    #  redirect "/other/faliure"
    end

    @plan.save
#original
    #redirect to "/plans/:id"
    redirect to "/plans/#{@plan.id}"
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
      #@user = User.new
      @plan = Plan.find(params[:id])
#WHEN I type in the number 1 or 2 after the /plans/1 like this then it takes me to the
#show page aka plans/show
      erb :'/plans/show'
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

get "/other/failure" do
    erb :'failure'
  end

    delete "/plans/:id" do
      Plan.destroy(params[:id])
      redirect to "/plans/account"
    end

end
