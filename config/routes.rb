Rails.application.routes.draw do
  devise_for :users, :path => 'u'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "articles#index"

  resources :articles
  resources :users_admin
end
