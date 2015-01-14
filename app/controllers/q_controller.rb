class QController < ApplicationController
  before_filter :authenticate_user!

  def index
    if(@current_user == nil)  
      redirect_to "/signin"
    end
  end
  
  def query
    if(params[:q] and params[:q] != "" and @current_user)
      github = Github.new client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET'], user: @current_user.nickname, oauth_token: @current_user.auth_token
      more_results, next_page_url, items = nil
      
      begin
        term = params[:q]
        term = "#{term}+language:#{params[:lang]}" if params[:lang]
        response = github.search.repos(q: term, sort: "stars")
        items = response.body.items unless response == nil 
        more_results = response.has_next_page?
        next_page_url = response.next_page 
      rescue
        puts "Hit an error in the github api call"
      end
      
      if(items)
        render :partial => "results_list", :locals => {items: items, query: params[:q], more_results: more_results, next_page_url: next_page_url}  
      else
        render :partial => "result_error", :locals => {message: "We encountered an error with your search. Please try again."}
      end
    else
      render :partial => "result_error", :locals => {message: "Please enter a term to search."}
    end
       
  end
  
  def more_results
    
  end
  
end
