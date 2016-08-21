Rails.application.routes.draw do
  resources :customers
  resources :employees
  resources :orders
  resources :menus
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  get '/api' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
