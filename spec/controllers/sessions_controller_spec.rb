require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET #new" do
    it "renders the :new view" do
      get :new 
      expect(response).to render_template("new")
    end
  end
    
  describe "GET #destroy" do
    before do
      session[:u_id] = 1
      get :destroy
    end
    
    it "destroys the user's session" do
      expect(session[:u_id]).to eql(nil)
    end
    
    it "redirects to the home page" do
      expect(response).to redirect_to(:controller => :q, :action => :index)
    end
  end  
end




