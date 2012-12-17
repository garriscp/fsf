Fsf::Application.routes.draw do
  
  get "memos/new"

  get "players/new"

  get "teams/new"

  devise_for :users

  root :to => 'teams#index'
end
