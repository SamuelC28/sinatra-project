class UsersController < ApplicationController
  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end
  
  get "/signup" do
    
    if Helpers.is_logged_in? session
      redirect '/menu'
    else
      erb :"users/signup"
    end
  end
  

  post "/signup" do
    @user = User.new params
    @user.save
    
    if @user.save
      Helpers.current_user session
      session[:user_id] = @user.id
      redirect "/menu"
      puts user.inspect
    else
      # flash[:signup] = "Failed to signup, missing some parameters."
      redirect "/signup"
    end
  end


  get '/menu' do
    
    # puts Helpers.current_user(session).username 
    if Helpers.is_logged_in? session
      @user = Helpers.current_user(session)
     
      erb :"users/menu"
    else
      redirect "/login"
    end
  end

  post '/menu' do
    # binding.pry
    if Helpers.is_logged_in? session
        erb :"users/menu" 
    else
      redirect to '/login'
    end
  end


  # get '/new/identifications' do
  #  if Helpers.is_logged_in? session
  #    erb :'identifications/new_identification'
  #  else
  #    redirect to '/login'
  #  end
  # end
  # get "/signup" do
  #   # binding.pry
  #   if Helpers.is_logged_in? session
  #     redirect '/identifications'
  #   else
  #     erb :"users/signup"
  #   end
  # end
  
  # post "/signup" do
  #   # binding.pry
  #   user = User.new params

  #   if user.save
  #     session[:user_id] = user.id    
  #     redirect "/identifications"
  #   else
  #     # flash[:signup] = "Failed to signup, missing some parameters."
  #     redirect "/signup"
  #   end
  # end

  get '/login' do
    if Helpers.is_logged_in? session
      redirect '/menu'
    else
      erb :"users/login"
    end
  end
  

  post '/login' do
    # binding.pry
    user = User.find_by(username: params[:username]) unless params[:username].empty?

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/menu"
    else
      # flash[:error_login] = "Failed to login, something wrong with yours informations."
      redirect "/login"
    end
  end

  get '/logout' do
    if Helpers.is_logged_in? session
      session.clear
      redirect to '/'
    end
  end

end
