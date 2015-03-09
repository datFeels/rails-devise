Rails.application.routes.draw do
  resources :post_attachments

  resources :posts

  root to: 'visitors#index'
  devise_for :users
  resources :users
  
  match 'like' => 'users#like', :via => [:post]
  match 'unlike' => 'users#unlike', :via => [:post]
end
