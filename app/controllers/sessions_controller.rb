class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user = find_or_create_user_from_auth_hash(auth_hash)
    if(@user)
      session[:u_id] = @user.id
      notice = "Account Created!"
      status = :ok
    else
     notice = "Unable to authenticate with Github. Please try again." 
     status = :unauthorized
    end
    redirect_to '/', :notice => notice, :status => status
  end

  def destroy
    session[:u_id] = nil
    redirect_to root_url, :notice => "You have been signed out!"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
  
  private
  
  def find_or_create_user_from_auth_hash(a_hash)
    u = User.find_by_gh_uid(a_hash['uid'])
    if(u == nil)
      u = User.new(nickname: a_hash['info']['nickname'], gh_uid: a_hash['uid'], image_url: a_hash['info']['image'], auth_token: a_hash['credentials']['token'])
      u.name = u.nickname unless a_hash['info']['name'] != nil
      if(u.save == false)
        u = nil
      end
    end
    u    
  end
  
end


# Example of Auth Hash

#  Parameters: {"code"=>"b029b058a64ac86a8fcc", "state"=>"1aad6cf4acc424f32b8d5284bfa9fa1d34f55fb3e9eea506", "provider"=>"github"}

#<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=false token="90017c010fc95d4e46c82852472b71748714728c"> 
#extra=#<OmniAuth::AuthHash raw_info=#<OmniAuth::AuthHash avatar_url="https://avatars.githubusercontent.com/u/5280814?v=3" 
#created_at="2013-08-21T18:29:16Z" events_url="https://api.github.com/users/Brandon-F5/events{/privacy}" 
#followers=0 followers_url="https://api.github.com/users/Brandon-F5/followers" 
#following=0 following_url="https://api.github.com/users/Brandon-F5/following{/other_user}" 
#gists_url="https://api.github.com/users/Brandon-F5/gists{/gist_id}" gravatar_id="" 
#html_url="https://github.com/Brandon-F5" id=5280814 login="Brandon-F5" 
#organizations_url="https://api.github.com/users/Brandon-F5/orgs" public_gists=0 public_repos=0 
#received_events_url="https://api.github.com/users/Brandon-F5/received_events" repos_url="https://api.github.com/users/Brandon-F5/repos" 
#site_admin=false starred_url="https://api.github.com/users/Brandon-F5/starred{/owner}{/repo}" 
#subscriptions_url="https://api.github.com/users/Brandon-F5/subscriptions" type="User" updated_at="2015-01-12T18:51:56Z" 
#url="https://api.github.com/users/Brandon-F5">>
#info=#<OmniAuth::AuthHash::InfoHash email=nil 
#image="https://avatars.githubusercontent.com/u/5280814?v=3" name=nil nickname="Brandon-F5" 
#urls=#<OmniAuth::AuthHash Blog=nil GitHub="https://github.com/Brandon-F5">> provider="github" uid="5280814">