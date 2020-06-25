class PlansController < ApplicationController
#create
    get "/plans" do
      erb :index
    end
#read
    get "/plans/account" do
      erb :'/plans/account'
    end
#update
    get "/plans/:id/edit" do
      @plans = Plan.find(params[:id])
      erb :'/plans/edit'
    end

    get "/plans/:id" do
    @plan = Plan.find(params[:id])
    erb :'/plans/account'
  end

    patch "/plans/:id" do
      @plan = Plan.find(params[:id])
      @plan.update(params[:person][:plan])
   redirect to "/plan/#{ @plan.id }"
    end
#delete
    delete "/plans/:id" do
      Plan.destroy(params[:id])
      redirect to "/plans/account"
    end

end
