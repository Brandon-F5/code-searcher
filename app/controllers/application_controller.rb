class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception
 before_filter :check_uri
 helper_method :current_user, :authenticate_user!
  
 def check_uri
   url = redirect_to request.protocol + 'www.' + request.host_with_port + request.fullpath if Rails.env.to_s == 'production' && !/^www/.match(request.host) && ENV['DEV'].nil?
 end

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
