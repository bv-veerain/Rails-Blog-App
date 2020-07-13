class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "You have logged in"
            redirect_to users_path(user)
        else
            flash.now[:danger] = "There was something wrong with your login information"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You have successfully logged out"
        redirect_to root_path
    end

    def require_user
        if !logged_in?
         flash[:danger] = "You must be logged in to perform that action"
         redirect_to root_path
        end
    end
end