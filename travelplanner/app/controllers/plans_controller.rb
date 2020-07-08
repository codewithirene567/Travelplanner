class PlansController < ApplicationController
  
   get "/plans/new" do
       if logged_in?
        erb :'/plans/new'
      else
        redirect to '/login' 
      end
    end

    post '/plans' do 
        if params[:plan][:name] == "" || params[:plan][:destination] == "" || params[:plan][:mode_of_transport] == "" || params[:plan][:date] == ""
          redirect to '/plans/new'
        else
          @plan = Plan.create(name: params[:plan][:name],
          destination: params[:plan][:destination], mode_of_transport: params[:plan][:mode_of_transport],
          date: params[:plan][:date], user_id: current_user.id)
            redirect to "/plans"
        end
      end

    get "/plans" do
      if logged_in?
         @user = current_user
         @plans = @user.plans
          erb :'users/show'
      else
        redirect to '/login'
      end
    end

    get "/plans/search" do
      if !logged_in?
        redirect to '/login'
      end
      @plans = Plan.all
      if params[:search]
        @plans = current_user.plans.where('destination = ?', params[:search])
      end
      erb :'/plans/search'
    end

     get "/plans/:id" do
        if !logged_in? 
          redirect to '/login'
        end
        @plan = Plan.find_by_id(params[:id])
        if @plan.user_id == session[:user_id]
        erb :'/plans/show'
        elsif @plan.user_id != session[:user_id]
          redirect '/plans'
        end
      end
    
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
      @plan = current_user.plans.find_by_id(params[:id])
      @plan.name = params[:plan][:name]
      @plan.destination = params[:plan][:destination]
      @plan.mode_of_transport = params[:plan][:mode_of_transport]
      @plan.date = params[:plan][:date]
      @plan.save
      redirect to "/plans/#{@plan.id}"
      end
     end


    get "/failure" do
        erb :'/failure'
      end

   
    delete '/plans/:id' do
      if logged_in?
         @plan = current_user.plans.find_by(params[:id])
         @plan.destroy
         redirect to "/plans"
     else
       redirect to '/login'
      end
    end

  end
     
