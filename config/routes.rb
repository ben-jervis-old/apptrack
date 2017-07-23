Rails.application.routes.draw do
  resources :notes
	resources :companies, 	only: [:show, :new, :create]
  resources :applications
	resources :users
	resources :account_activations, only: [:edit]
	resources :password_resets,			only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 'applications#index'

	get 		'/login', 		to: 'sessions#new'
	post 		'/login', 		to: 'sessions#create'
	delete 	'/logout', 		to: 'sessions#destroy'
end
