class UsersController < ApplicationController   
before_action :find_user, only: [:show, :edit, :update, :delete]

    def index
    end
    def show

    end
    def new
        @user = User.new
    end
    def create
        # if params[:user][:email] == params[:user][:email_confirmation] && params[:user][:password] == params[:user][:password_confirmation]
            # sanitize_params
            @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id

                redirect_to user_path(@user)
            else
                render "users/new"
            end
        # end
    end
    def edit

    end
    def update

    end
    def delete
        
    end

    private
    def user_params
        params.require(:user).permit(:username, :about, :password, :age, :email)
    end

    def sanitize_params
        params[:user].delete_if{|k,v| k == :email_confirmation || k == :password_confirmation}
    end

    def find_user
        @user = User.find_by(id: params[:id])
    end
end
