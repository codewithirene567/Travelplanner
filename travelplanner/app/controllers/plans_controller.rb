class PlansController < ApplicationController
#create
   get "/plans/new" do
       if logged_in?
        erb :'/plans/new'
      else
        redirect to '/login'
      end
    end

    post '/plans' do #creates a new travel plan and posts it so they can see it
    #if you can't see it usually  wasn't created correctly
    if params[:plan][:name] == "" || params[:plan][:destination] == "" || params[:plan][:mode_of_transport] == "" || params[:plan][:date] == ""
      redirect to '/plans/new'
    else
      user = current_user
   @plan = Plan.create(name: params[:plan][:name],
   destination: params[:plan][:destination], mode_of_transport: params[:plan][:mode_of_transport],
   date: params[:plan][:date])

      #@plan.user = current_user

    #@plan.save
    redirect to "/plans/#{@plan.id}"
    end
  end

#read

    get "/plans" do
      if logged_in?
         @user = current_user
         @plans = @user.plans.all
        erb :'/plans/index'
      else
        redirect to '/login'
      end
    end

    get "/plans/:id" do
      if logged_in?
          @plan = Plan.find_by_id(params[:id])#the only thing that can get sent into find is an id
          if @plan.user_id == session[:user_id]
          erb :'/plans/show'
          elsif @plan.user_id != session[:user_id]
            redirect '/plans'
          end
        else
          redirect to '/plans'
        end
      end
    #end
#update
    get "/plans/:id/edit" do
      if logged_in?
        @plan = Plan.find_by_id(params[:id])
        if @plan.user_id == session[:user_id]
         erb :'/plans/edit'
       else
         redirect to '/plans'
        end
     else
       redirect to '/login'
     end
    end

    patch "/plans/:id" do
      if params[:plan][:name] == "" || params[:plan][:destination] == "" || params[:plan][:mode_of_transport] == "" || params[:plan][:date] == ""
        redirect to "/plans/#{params[:id]}/edit"
      else
      @plan = Plan.find_by_id(params[:id])
      @plan.name = params[:plan][:name]
      @plan.destination = params[:plan][:destination]
      @plan.mode_of_transport = params[:plan][:mode_of_transport]
      @plan.date = params[:plan][:date]
      @plan.user_id = current_user.id
      @plan.save
      #@plan.update(params[:user][:plan])
      redirect to "/plan/#{@plan.id}"
      end
     end


get "/failure" do
    erb :'/failure'
  end

    delete '/plans/:id/delete' do
      if logged_in?
       @plan = Plan.find_by(params[:id])
        if @plan.user_id == session[:user_id]
         @plan.delete
         redirect to '/plans'
       end
     else
       redirect to '/login'
      #, destination: params[:plan][:destination], mode_of_transport:
      #params[:plan][:mode_of_transport], date: params[:plan][:date], user_id: params[:plan][:user_id])
     end
    end

  end
      #redirect '/users/show'

      #Plan.destroy(params[:id])
      #redirect to "/users/show"
    #end
