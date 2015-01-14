class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.find_or_create_user_from_auth_hash(auth_hash)
    if(@user)
      session[:u_id] = @user.id
    end
    redirect_to root_url
  end

  def destroy
    session[:u_id] = nil
    redirect_to root_url, :notice => "You have been signed out!"
  end

  def failure
    session[:u_id] = nil
    redirect_to :new, :notice => "There was an error with your authorization. Please try again"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
    
end
