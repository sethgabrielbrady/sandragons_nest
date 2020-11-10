class UsersController < ApplicationController
    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:index]


    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
          UserMailer.registration_confirmation(@user).deliver
          session[:user_id] = @user.id
          redirect_to root_url, notice: "You rolled a natural 20 on signing up!"
        else
          flash[:error] = "Ooooppss, something went wrong!"
          render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to @user, notice: "Account successfully updated!"
        else
          render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil
        redirect_to root_url, alert: "Account successfully deleted!"
    end

    def confirm_email
        user = User.find_by_confirm_token(params[:id])
        if user
          user.email_activate
          flash[:success] = "Welcome to Sandragon! Please sign in to continue."
          redirect_to signin_url
        else
          flash[:error] = "Sorry. User does not exist"
          redirect_to root_url
        end
    end
      
    private
      
    def user_params
        params.require(:user).
        permit(:name, :email, :password, :password_confirmation, :username, :avatar)
    end

    def require_correct_user
        @user = User.find(params[:id])
        redirect_to root_url unless current_user?(@user)
    end
end
