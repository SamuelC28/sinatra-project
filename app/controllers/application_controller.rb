require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "haitian_citizen_id_book"
  end

  get '/' do
    erb :index
  end

end
