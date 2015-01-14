class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception
 helper_method :current_user, :authenticate_user!

 def current_user
   @current_user ||= User.find_by_id(session[:u_id])
 end

 def authenticate_user!
   if session[:u_id]
     current_user
   else
     nil
   end
 end
  
end
