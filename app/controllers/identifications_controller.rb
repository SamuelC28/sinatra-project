class IdentificationsController < ApplicationController
  use Rack::Flash
  
  get '/identifications' do   
    if Helpers.is_logged_in? session 
      @user = Helpers.current_user session
      
      puts @user.id.inspect
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
      
      @user = Helpers.current_user(session)
      # puts @user.inspect
      identification = Helpers.current_user(session).identifications.build(firstname: params[:firstname], lastname: params[:lastname], date_of_birth: params[:date_of_birth], country_of_birth: params[:country_of_birth], nationality: params[:nationality], sex: params[:sex], address: params[:address], expiry_date: params[:expiry_date] = Date.today + (365 * 5))
      puts identification.inspect
      
      if identification.save && identification.user == @user
        # puts identification.inspect
        redirect to "/identifications/#{identification.id}"
      else
        flash[:error_create_id] = "You have missed 1 or several fields. Try again!"
        redirect to "/identifications/new"
      end
    else
      flash[:error_login] = "You did not log in yet!"
      redirect to '/login'
    end
  end

  # View all identifications created by all users
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
      flash[:error_login] = "You did not log in yet!"
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
      flash[:error_edit] = "You have no right to edit this indetification!"
       redirect to '/identifications'
     end
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
      flash[:error_delete] = "You have no right to delete this indetification!"
      redirect to '/login'
    end
  end
end

