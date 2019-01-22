Rails.application.routes.draw do

  devise_for :users

  resources :questions do
    resource :vote, only: [:create, :destroy]
    resources :comments
    resources :answers 
  end

  resources :answers do
    resource :vote, only: [:create, :destroy]
    resources :comments
  end

  root 'questions#index'
  
end
