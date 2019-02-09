class IdentificationsController < ApplicationController

  get '/identifications' do   
    if Helpers.is_logged_in? session 
      @user = Helpers.current_user session
      
      puts @user.id.inspect
      # puts @identification.inspect
      erb :"identifications/identifications"
    else
      redirect "/login"
    end
  end

  get '/identifications/new' do
   if Helpers.is_logged_in? session
    @user = Helpers.current_user session
     erb :'identifications/new_identification'
   else
     redirect to '/login'
   end
  end

  post '/identifications' do
    if Helpers.is_logged_in? session
      @identification = Identification.find_by_id(params[:user_id])
      # puts @identification == @user[1]
      
      # @user = Helpers.current_user session
      # if @identification == @user
      #  current_date = Date.today
      #  set_expiry_date = current_date + (365 * 5)
      @user = Helpers.current_user(session)
      # puts @user.inspect
      identification = Helpers.current_user(session).identifications.build(firstname: params[:firstname], lastname: params[:lastname], date_of_birth: params[:date_of_birth], country_of_birth: params[:country_of_birth], nationality: params[:nationality], sex: params[:sex], address: params[:address])
      puts identification.user_id.inspect
      if identification.save && identification.user == @user
        # puts identification.inspect
        redirect to "/identifications/#{identification.id}"
      else
        redirect to "/identifications/new"
      end
    else
      redirect to '/login'
    end
  end

  # View all identifications crearted by all users
  get '/ViewAllCitizens' do
    if Helpers.is_logged_in? session
      @user = Helpers.current_user session
      erb :"identifications/all_registered_citizens"
    else
      redirect "/login"
    end
  end

  post '/identifications' do
    if Helpers.is_logged_in? session
      erb :"identifications/all_registered_citizens"
    else
      redirect to '/login'
    end
  end

  
  get '/identifications/:id' do
    if Helpers.is_logged_in? session
      @identification = Identification.find_by_id(params[:id])
      @user = Helpers.current_user session
      erb :'identifications/show_identification'
    else
      redirect to '/login'
    end
  end

  get '/identifications/:id/edit' do

   if Helpers.is_logged_in? session
    #  puts Helpers.is_logged_in?(session).inspect 
    @user= User.find session[:user_id]
    
     @identification = Identification.find(params[:id])
     if @identification.user == Helpers.current_user(session)
      # if @identification && @identification.user == Helpers.current_user(session)
       erb :'identifications/edit_identification'
     else
       redirect to '/identifications'
     end
  #  else
  #    redirect to '/login'
  end
  end

  patch '/identifications/:id' do
    if Helpers.is_logged_in? session
      #@user= User.find session[:user_id]
      identification = Identification.find_by_id(params[:id])
      if identification && identification.user == Helpers.current_user(session)
        if identification.update(firstname: params[:firstname], lastname: params[:lastname], date_of_birth: params[:date_of_birth], country_of_birth: params[:country_of_birth], nationality: params[:nationality], sex: params[:sex], address: params[:address])
           redirect to "/identifications/#{identification.id}"
        else
          redirect to "/identifications/#{identification.id}/edit"
        end
      else
        redirect to '/identifications'
      end
    else
      redirect to '/login'
    end
  end

  delete '/identifications/:id/delete' do
    if Helpers.is_logged_in? session
      identification = Identification.find_by_id(params[:id])
      if identification && identification.user == Helpers.current_user(session)
        identification.delete
      end
      redirect to '/identifications'
    else
      redirect to '/login'
    end
  end
end

