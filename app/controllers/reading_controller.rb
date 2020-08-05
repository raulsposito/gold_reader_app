class ReadingController < ApplicationController
    #NEED CRUD FOR THIS CONTROLLER 

    #User can create a new reading activity

    get '/readings/new' do 
        redirect_if_not_logged_in 
        erb :'/readings/new'
    end

    post '/readings' do 
        if logged_in?
            if params[:name].empty? || params[:image_url].empty? || params[:location].empty? || params[:genre].empty?
                flash[:errors] = "Sorry! Colmun(s) cannot be left blank!!!"
                redirect to '/readings/new'
            else
                @reading = Reading.new(name: params[:name], image_url: params[:image_url], location: params[:location], genre: params[:genre])
                @reading.user_id = current_user.id 
                @reading.save 
                flash[:message] = "You have successfully created a Reading!"
                redirect "/readings/#{@reading.id}"
            end
        else 
            redirect '/login'
        end
    end
    
    #User can view available reading activities

    get '/readings' do 
        #People can see readings available. To engage people in case they aren't singed up to maybe see a reading they find interesting.
        @readings = Reading.all 
        erb :'/readings/all_readings'
    end

    get '/readings/:id' do 
        find_reading 
        erb :'/readings/show_reading'
    end

    #User can Edit their posted activities

    get '/readings/:id/edit' do 
        redirect_if_not_logged_in
        find_reading 
        if authorized_user?(@reading)
            erb :'reading/edit_reading'
        else 
            flash[:errors] = "You are not the owner of this reading but you are welcome to join if you'd like."
            redirect "/readings/#{@reading.id}"
        end
    end

    patch '/readings/:id' do 
        find_reading 
        if params[:name].empty? || params[:image_url].empty? || params[:location].empty? || params[:genre].empty?
            flash[:errors] = "Please complete all fields to update the reading."
            redirect "/readings/#{@reading.id}/edit"
        else 
            @reading.update(name: params[:name], image_url: params[:image_url], location: params[:location], genre: params[:genre])
            flash[:message] = "You have updated this reading!"
            redirect "/readings/#{@reading.id}"
        end
    end
    
    #User can Delete a reading activity that they posted

    delete '/readings/:id/delete' do 
        redirect_if_not_logged_in
        find_reading
        if authorized_user?(@reading)
            @reading.destroy 
            flash[:message] = "You have successfully deleted your reading."
            redirect '/' #since there is no reading to redirect to.
        else 
            flash[:errors] = "You cannot delete a reading you don't own."
            redirect "/readings/#{@reading.id}"
        end
    end
    
end