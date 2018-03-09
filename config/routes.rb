Rails.application.routes.draw do
  resources :submissions
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :solutions
  resources :problems

  root 'pages#intro'

  get '/intro', to: 'pages#intro'
  get '/team', to: 'pages#team'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
