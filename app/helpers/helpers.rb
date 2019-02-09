class Helpers
  def self.current_user session
    # begin
      @user= User.find_by id: session[:user_id]
    # rescue ActiveRecord::RecordNotFound 
    #   nil
    # end
  end

  def self.is_logged_in? session
    !!session[:user_id]#.nil? ? false : true
  end

end
