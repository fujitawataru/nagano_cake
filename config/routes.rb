Rails.application.routes.draw do
  devise_for :admins, :controllers => {
    :registrations => 'admins/rejistrations',
    :sessions => 'admins/sessions'
  }
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'homes#top'
get 'home/about' => 'homes#about'

get 'customers/my_page' => 'customers#show', as: 'my_page'
get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
resource :customers, only: [ :edit, :update]

devise_for :customers

resources :items, only: [ :index, :show]

delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
resources :cart_items, only: [ :index, :update, :destroy, :create]

post 'orders/confirm' => 'orders#confirm'
get 'orders/complete' => 'orders#complete'
resources :orders, only: [ :new, :create, :index,:show]

resources :addresses, only: [ :index, :edit, :create, :update, :destroy]


namespace :admin do
  resources :items, only: [ :index, :new, :create, :show, :edit, :update]
  resources :customers, only: [ :index, :show, :edit, :update]
  resources :genres, only: [ :index, :create, :edit, :update]
  resources :orders, only: [ :index, :show, :update] do
  resources :order_details, only: [ :update]
end
end

end
