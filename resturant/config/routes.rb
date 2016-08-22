Rails.application.routes.draw do
  resources :users  do
    collection do
      post 'authenticate'
    end
    resources :orders
  end
  resources :orders do
    resources :items
  end
  resources :menus do
    resources :items
  end
  resources :items

  get '/api' => redirect('/swagger/dist/index.html?url=/api/api-docs.json')
end
