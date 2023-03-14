class UsersController < ApplicationController
    def new
        @users = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
          session[:user_id] = @user.id
          redirect_to root_path
      else
          flash[:notice] = @user.errors.full_messages.to_sentence
          redirect_to register_path    
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_conformation, :mobile_number) 
    end

end
