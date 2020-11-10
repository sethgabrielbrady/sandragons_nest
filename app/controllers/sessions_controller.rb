class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.find_by_email(params[:email].downcase)
      if user = User.authenticate(params[:email], params[:password])
        if user.email_confirmed
          session[:user_id] = user.id
          flash[:notice] = "Welcome back, #{user.name}!"
          redirect_to(session[:intended_url] || user)
          session[:intended_url] = nil
        else
          flash.now[:error] = 'Please activate your account by following the 
          instructions in the account confirmation email'
          render 'new'
        end
      else
        flash.now[:alert] = "Invalid email/password combination!"
        render :new
      end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "You're now signed out!"
    end
end