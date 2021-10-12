Rails.application.routes.draw do
  devise_for:customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }
  scope module: :customers do
    root to:'homes#top'
    get '/about' => 'homes#about'
    resources :items, only:[:index,:show]
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only:[:edit,:update]
    get 'customers/unsubscribe' => 'customers#unsubscribe', as:'customers_unsubscribe'
    get '/customers/my_page' => 'customers#show'
    resources :addresses, only:[:index,:edit,:create,:update,:destroy]
    delete '/cart_items/all_destroy' => 'cart_items#all_destroy', as:'cart_items_all_destroy'
    resources :cart_items, only:[:index,:update,:create,:destroy]
    #post '/orders/new' => 'orders#new'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    resources :orders, only:[:index,:create,:new,:show]

  end

  devise_for(
    :admins,
    path: 'admin',
    module: 'devise'
    )

    namespace :admin do
      root to:'homes#top'
      patch '/items/:id' => 'items#update', as:'update_items'
      resources :items, only:[:index,:new,:show,:edit,:create]
      resources :genres, only:[:index,:create,:edit,:update]
      resources :customers, only:[:index,:edit,:show]
      patch '/customers/:id' => 'customers#update', as:'update_customers'
      resources :orders, only:[:show,:update]
      resources :order_details, only:[:show,:update]
    end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
