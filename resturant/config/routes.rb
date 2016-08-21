Rails.application.routes.draw do
  resources :users  do
    collection do
      post 'authenticate'
    end
  end
  resources :orders
  resources :menus
  resources :items

  get '/api' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')
end
