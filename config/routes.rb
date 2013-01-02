Fsf::Application.routes.draw do
  
  match ":id/teams/prepare" => "teams#prepare", :as => :prepare
  match ":id/teams/new" => "teams#new", :as => :new
  #match ':id/teams/prepare', :controller => 'teams', :action => 'show'
  
  root :to => 'teams#home'
  
  get "memos/new"

  get "players/new"

  devise_for :users, :path => "accounts"
  
  resources :users, :path => "" do
    resources :teams
  end
  
  
end
