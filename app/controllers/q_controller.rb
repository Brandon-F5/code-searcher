class QController < ApplicationController
  
  def index
    @user = authenticate_user!  
  end
  
  def query
    
    render :partial => "results_list" #, :locals => {results: items}
  end
  
  def more_results
    
  end
  
  
end
