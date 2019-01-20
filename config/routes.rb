Rails.application.routes.draw do

  devise_for :users

  resources :questions do
    resources :comments
    resources :answers 
  end

  # resources :questions do
  resources :answers do
    resources :comments
  end
  # end

  # get '/answers', to: redirect('/questions')

  # resources :questions do
  #   resources :answers do
  #     resources :comments
  #   end
  # end
  
  root 'questions#index'
  
end
