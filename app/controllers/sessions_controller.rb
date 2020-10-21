class SessionsController < ApplicationController
    layout :set_layout


    def new  
    end

    def create
        user_or_creator_login
    end

    def delete
        if session[:user_id]
            session[:user_id].clear
        elsif session[:creator_id]
            session[:creator_id].clear
        else
            render :root
        end
    end

    #!create a cart and/or add Merchandise to the cart
    def add_to_cart
        session[:user_cart] ||= []
        session[:user_cart] << params[:id]
        redirect_to merchandise_path(params[:id])
    end

    def remove_from_cart
        session[:user_cart].delete_if { |merch_id| merch_id == params[:id] }
        redirect_to merchandise_path(params[:id])
    end

    def current_user
        User.find_by(id: session[:user_id])
    end

    def current_creator
        Creator.find_by(id: session[:creator_id])
    end

    def current_user_or_creator?
        if session[:user_id] || session[:creator_id]
            true
        else
            false
        end
    end

    def current_user_or_creator
        if session[:user_id]
            current_user
        elsif session[:creator_id]
            current_creator       
        else
            false
        end
    end

    private
    def user_or_creator_login
        if params[:u_c] == "u"

            if !params[:username].blank?
               User.find_user_by_username
               if @user
                session[:user_id] = @user.id

                redirect_to user_path(@user)
               else render "sessions/new"
               end

            elsif !params[:email].blank?
                User.find_user_by_email
                if @user
                    session[:user_id] = @user.id

                    redirect_to user_path(@user)
                else
                    render "sessions/new"
                end
            end

        elsif params[:u_c] == "c"
            if !params[:username].blank?
                find_creator_by_username
                if @creator
                    session[:creator_id] = @creator.id
                    redirect_to creator_path(@creator)
                else 
                    render "sessions/new"
                end

            elsif !params[:email].blank?
                find_creator_by_email
                if @creator
                    session[:creator_id] = @creator.id
                    redirect_to creator_path(@creator)
                else
                    render "sessions/new"
                end
            else
                render "sessions/new"
            end
        else
            render "sessions/new"
        end
    end

    def find_creator_by_username
        @creator = Creator.find_by(username: params[:username])
    end

    def find_creator_by_email
        @creator = Creator.find_by(email: params[:email])
    end
end