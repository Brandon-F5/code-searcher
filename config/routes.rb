Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'q#index'
  
  # Query Routes
  get 'q' => 'q#index'
  post "/query" => "q#query"
  get  "/query" => "q#query"
  
  # Session Routes
  get '/signin' => 'sessions#new', :as => :signin
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'  
  get "/signout" => "sessions#destroy", :as => :signout
    
  
end
