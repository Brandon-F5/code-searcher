require 'rails_helper'

RSpec.describe QController, :type => :controller do  
  let!(:user) { FactoryGirl.build(:user, name: "Brandon", nickname: "Brandon-F5", email: 'test@test.local', gh_uid: '12345678', auth_token: "987654321", image_url: "https://avatars.githubusercontent.com/u/5280814?v=3") }
  bad_params =  {:q => ""}

  describe "GET #index" do    
    before do
      controller.instance_variable_set(:@current_user, user)
    end
    
    it "renders the :index view" do
      get :index 
      expect(response).to render_template("index")
    end
  end
  
  describe "GET #query" do
        
    context "with incorrect attributes" do
      before do
        controller.instance_variable_set(:@current_user, user)
        get :query, bad_params  
      end
        
      it "renders the :results_error partial" do
        expect(response).to render_template(:partial => "_result_error")
      end  
    end
  
  end
  
  describe "POST #query" do
          
    context "with incorrect attributes" do
      before do
        controller.instance_variable_set(:@current_user, user)
        post :query, bad_params
      end
      
      it "renders the :results_error partial" do
        expect(response).to render_template(:partial => "_result_error")
      end
    end
  end
  
end
