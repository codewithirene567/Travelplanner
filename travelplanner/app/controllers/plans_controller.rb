class PlansController < ApplicationController
#create
   get "/plans/new" do #this is the create action which represents what happens whenever somebody makes a new plan
       if logged_in? #if they are logged in, then show them the erb plans/new page
        erb :'/plans/new'
      else
        redirect to '/login' #otherwise make them login
      end
    end

    post '/plans' do #creates a new travel plan and posts it so they can see it
    #if you can't see it usually  wasn't created correctly
    if params[:plan][:name] == "" || params[:plan][:destination] == "" || params[:plan][:mode_of_transport] == "" || params[:plan][:date] == ""
      redirect to '/plans/new'
    #this makes sure that the fields are not blank, otherwise it will take them to the new page to make the plan form be filled out correctly
    else
      #user = current_user
   @plan = Plan.create(name: params[:plan][:name],
   destination: params[:plan][:destination], mode_of_transport: params[:plan][:mode_of_transport],
   date: params[:plan][:date], user_id: current_user.id)
#this gives each of the plans their attributes
      #@plan.user = current_user

    #@plan.save! #if for some reason the plan didn't save, then raise an error
    redirect to "/plans" #taking us to a specific plan
    #redirect to "/plans/#{@plan.id}"
    end
  end

#read

    get "/plans" do
      if logged_in?
         @user = current_user
         @plans = @user.plans
        #erb :'/plans/index'
        #binding.pry
          erb :'users/show'
          #erb :'/plans/show'
      else
        redirect to '/login'
      end
    end

    get "/plans/search" do
      #load a view that will display the search results
      #redirect_if_logged_out(session)
      if !logged_in?
        redirect to '/login'
      end
      @plans = Plan.all
      if params[:search]
        @plans = current_user.plans.where('destination = ?', params[:search])
      end
      erb :'/plans/search'
    end

    #get "/plans/:id" do
    #  if logged_in? #typically in get request params come from url and posts have it come from the form
      #    @plan = Plan.find_by_id(params[:id])#the only thing that can get sent into find is an id
      #    if @plan.user_id == session[:user_id]
      #    erb :'/plans/show'
      #    elsif @plan.user_id != session[:user_id]
      #      redirect '/plans'
      #    end
      #  else
      #    redirect to '/plans'
      #  end
      #end

     get "/plans/:id" do
        if !logged_in?  #these three lines could be turned into a helper method
          redirect to '/login'
        end
        @plan = Plan.find_by_id(params[:id])#the only thing that can get sent into find is an id
        if @plan.user_id == session[:user_id]
        erb :'/plans/show'
        elsif @plan.user_id != session[:user_id]
          redirect '/plans'
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
      @plan = current_user.plans.find_by_id(params[:id])#found the plan be looking at the current user's plans
      @plan.name = params[:plan][:name]
      @plan.destination = params[:plan][:destination]
      @plan.mode_of_transport = params[:plan][:mode_of_transport]
      @plan.date = params[:plan][:date]
      #@plan.user_id = current_user.id
      @plan.save
      #@plan.update(params[:user][:plan])
      redirect to "/plans/#{@plan.id}"
      end
     end


    get "/failure" do
        erb :'/failure'
      end

    #delete '/plans/delete' do
    delete '/plans/:id' do
      if logged_in?
         @plan = current_user.plans.find_by(params[:id]) #find the plan and then if that plan has a user id which is equal to the session id then take it back to plans
         @plan.destroy
         redirect to "/plans"
     else
       redirect to '/login'
      end
    end

  end
      #redirect '/users/show'

      #Plan.destroy(params[:id])
      #redirect to "/users/show"
    #end
