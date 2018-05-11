Rails.application.routes.draw do
	root 'books#index'
  resources :books do
  	member do
  		put 'publish'
  	end
  end
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
