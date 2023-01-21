Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }


  namespace :admin do
    resources :orders, only: [:show, :update]
    get "/" => "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :create, :new, :show, :edit, :update]
    resources :order_details, only: [:update]
    get "/search" => "items#search"
  end
  scope module: :public do
    resources :shopping_addresses, only: [:index, :create, :destroy, :edit, :update]
    # get "/customers/mypage" => "customers#show"
    get "/customers/:id/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
    patch "/customers/:id/withdraw" => "customers#withdraw", as: "withdraw"
    resources :customers, only: [:show, :update, :edit]
    post "/orders/confirm" => "orders#confirm"
    get "/orders/complete" => "orders#complete"
    resources :orders, only: [:new, :create, :show, :index]
    delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :create, :destroy, :update]
    resources :items, only: [:index, :show]
    root "homes#top"
    get "/about" => "homes#about"
    get 'search' => "items#search"
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
