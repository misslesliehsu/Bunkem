class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorized #this line says no matter what you do, you have to be logged_in

  helper_method :signed_in?, :current_user_id, :current_user
#helper methods are made avavailable in Views

  #BEFORE any of the below come into play,  session[:user_id] has already been established, via an action in the SessionsController (which is triggered by visiting root signin page & submitting username/pw)
  def current_user_id #use this method to return the appropriate User id
    session[:user_id]
    #if one is signed_in - you get nothing back
  end

  def current_user
    User.find(current_user_id) if current_user_id
    #returns nil if no current_user, otherwise returns User object
  end

  def signed_in?  #turns current_user_id into a "does this exist"?
     !!current_user_id
     #returns T if current_user isn't nil, returns F if it is nil
  end


  def authorized
    #b/c this is in the application controller, and we have the line "before_action :authorized" -- this means before ANY controller action starts, this method will be triggered
    #this method either does nothing (no gates put up), or if there is no user/ they are not logged in, then will send them to login page
    redirect_to signin_path unless signed_in?
  end

end
