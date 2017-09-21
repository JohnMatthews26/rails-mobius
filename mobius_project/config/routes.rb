Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :index, :show]
  resources :transactions, only: [:new, :create, :index, :show, :destroy]
  # namespace :api, defaults: { format: :json } do
  #   namespace :v1 do
  #     resources :users, only: :show
  #   end
  # end
  match 'api/v1/users/current' => 'api/v1/users#show', :via => :get, defaults: { format: :json}
  root to: redirect('users/new')
end
