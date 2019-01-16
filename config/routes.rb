Rails.application.routes.draw do

  devise_for :users

  resources :questions do
    resources :comments, module: :questions
    resources :answers do
      resources :comments, module: :answers
    end
  end

  root 'questions#index'
  
end
