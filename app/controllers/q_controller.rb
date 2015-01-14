class QController < ApplicationController
  #before_filter :authenticate_user!
  
  def index
    @current_user = authenticate_user!  
    if(@current_user)  
      @loading_num = rand(7) + 1
      @@github = Github.new client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET'], user: @current_user.nickname, oauth_token: @current_user.auth_token
    else
      redirect_to "/signin"
    end
  end
  
  def query
    if(params[:q])
      response = @@github.search.repos(q: params[:q], sort: "stars")
            
      render :partial => "results_list", :locals => {items: response.body.items}  
    else
      render :text => "Please provide a search term."
    end
       
  end
  
  def more_results
    
  end
  
  
end
