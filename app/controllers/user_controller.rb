class UserController < ApplicationController

    get '/signup' do 
        erb :'/users/signup'
    end

    post '/users' do 
        @users = User.new(params)
        if @user.save 
            session[:user_id] = @user.id
            flash[:message] = "Welcome #{@user.name}! You can start reading or find someone who reads to you."
            redirect "/users/#{@user.id}"
        else 
            flash[:errors] = "Signup failed! Please make sure to include all details."
            redirect "/signup"
        end
    end

    #Login form get request
    get '/login' do 
        erb :'/users/login'
    end

    #Login form post request
    post '/login' do 
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password]) # has_secure_password macro authentication
            session[:user_id] = @user.id 
            flash[:message] = "Welcome back #{@user.name}."
            redirect "/users/#{@user.id}"
        else 
            flash[:errors] = "There was an error login in! Please try again."
            redirect '/login'
        end
    end

    get '/user/:id' do 
        @user = User.find_by(id: params[:id])
        erb :'/users/show_user'
    end

    get '/logout' do 
        session.clear 
        flash[:message] = "Thank you #{@user.name}! Reading is Gold."
        redirect '/'
    end
end