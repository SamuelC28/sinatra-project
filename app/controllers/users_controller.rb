class UsersController < ApplicationController
  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end
  
  #request the user's signup page
  get "/signup" do
    
    if Helpers.is_logged_in? session
      redirect '/menu'
    else
      erb :"users/signup"
    end
  end
  
  #prompt the user to signup and open the user session
  post "/signup" do
    @user = User.new params
    @user.save
    
    if @user.save
      Helpers.current_user session
      session[:user_id] = @user.id
      redirect "/menu"
      # puts user.inspect
    else
      flash[:signup] = "Oops! you've let some blank fields!"
      redirect "/signup"
    end
  end

 # request the menu if the user is logged in
  get '/menu' do
    if Helpers.is_logged_in? session
      @user = Helpers.current_user(session)
      erb :"users/menu"
    else
      redirect "/login"
    end
  end

  #post the user menu on the screen and promt the user to choose
  post '/menu' do
    # binding.pry
    if Helpers.is_logged_in? session
        erb :"users/menu" 
    else
      redirect to '/login'
    end
  end

  #request for the log in page if the user in not logged in
  get '/login' do
    if Helpers.is_logged_in? session
      redirect '/menu'
    else
      erb :"users/login"
    end
  end
  
  #show the log in page and open a session if user info are authentic
  post '/login' do
    # binding.pry
    user = User.find_by(username: params[:username]) unless params[:username].empty?

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/menu"
    else
      flash[:error_login] = "Your Email address or password is wrong!"
      redirect "/login"
    end
  end

  #prompt the user to logout
  get '/logout' do
    if Helpers.is_logged_in? session
      session.clear
      redirect to '/'
    end
  end
end
