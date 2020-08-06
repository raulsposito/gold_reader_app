require './config/environment'

class ApplicationController < Sinatra::Base

    configure do 
        set :public_folder, 'public'
        set :views, 'app/views'
        # enables sessions
        enable :sessions 
        # Sets sessions secure 
        set :session_secret, "secret_session"
        # Sets registration to Sinatra::Base 
        register Sinatra::Flash
    end

    get "/" do 
        if logged_in?
            redirect "users/#{current_user.id}"
        else
            erb :welcome
        end
    end

    helpers do 

        def logged_in?
            #Checks if the user is logged in or not
            !!current_user
        end

        def current_user 
            #Track the user that is logged in
            User.find_by(id: session[:user_id])
        end

        def redirect
            if !logged_in?
                flash[:errors] = "Please log in."
                redirect '/login'
            end
        end

        def authorized_user?(reading)
            reading.user_id == current_user.id
        end

        def find_reading
            @reading = reading.find(params[:id])
        end
    end
end
