class SessionsController < ApplicationController
before_action :find_user_or_creator, only: [:create]

    def new
        
    end
    def create
        user_or_creator_login
    end
    def delete
        
    end

    private
    def user_or_creator_login
        if params[:u_c] == "u"
            if params[:username]
               find_user_by_username
               if @user
                session[:user_id] = user.id
               else render "sessions/new"
               end
            elsif params[:email]
                find_user_by_email
                if @user
                    session[:user_id] = @user.id
                else
                    render "sessions/new"
                end
            end
        elsif params [:u_c] == "c"
            if params[:username]
                find_creator_by_username
                if @creator
                    session[:creator_id] = @creator.id
                else render "sessions/new"
                end
             elsif params[:email]
                find_creator_by_email
                if @user
                    session[:creator_id] = @creator.id
                else
                    render "sessions/new"
                end
             end
        else
            render "sessions/new"
        end
    end
    def find_user_or_creator
        if params[:u_c] == u
            user = User.find_by(id: params[:id])
        elsif params[:u_c] == c
            creator == Creator.find_by(id: params[:id])
        end
    end

end