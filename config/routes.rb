Fsf::Application.routes.draw do
  
  root :to => 'teams#index'
  
  get "memos/new"

  get "players/new"

  get "teams/new"

  devise_for :users, :path => "accounts"
  
  resources :users, :path => "" do
    resources :teams
  end
  
  
  
end
