class QController < ApplicationController
  before_filter :authenticate_user!

  def index
    if(@current_user == nil)  
      redirect_to "/signin"
    end
  end
  
  def query
    if(params[:q] and params[:q] != "" and @current_user)
      more_results, items = nil
      page_num = 1
      if(params[:page])
        page_num = params[:page].to_i + 1
      end
      order = "desc"
      if(params[:order])
        order = params[:order]
      end
      
      #begin
        @github = Github.new client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET'], user: @current_user.nickname, oauth_token: @current_user.auth_token
        term = params[:q]
        term = "#{term}+language:#{params[:lang]}" if params[:lang]
        response = @github.search.repos(q: term, sort: "stars", order: order, page: page_num)
        items = response.body.items unless response == nil 
        more_results = response.has_next_page?
        if(more_results)
          page_num = page_num + 1
        end
      #rescue
        puts "Hit an error in the github api call"
      #end
      
      if(items)
        render :partial => "results_list", :locals => {items: items, query: term, more_results: more_results, page_num: page_num}  
      else
        render :partial => "result_error", :locals => {message: "We encountered an error with your search. Please try again."}
      end
    else
      render :partial => "result_error", :locals => {message: "Please enter a term to search."}
    end
       
  end
  
end
