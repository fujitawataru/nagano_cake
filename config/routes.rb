Rails.application.routes.draw do
  devise_for :admins, :controllers => {
    :registrations => 'admins/rejistrations',
    :sessions => 'admins/sessions'
  }
  devise_scope :admins do
    get "sign_in", :to => "admins/sessions#new"
    get "sign_out", :to => "admins/sessions#destoroy"
  end

  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'homes#top'
get 'home/about' => 'homes#about'

resources :items, only: [ :index, :show]

delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
resources :cart_items, only: [ :index, :update, :destroy, :create]

post 'orders/confirm' => 'orders#confirm'
get 'orders/complete' => 'orders#complete'
resources :orders, only: [ :new, :create, :index, :show]

resources :addresses, only: [:index, :edit, :create, :update, :destroy]


namespace :admin do
  resources :items, only: [ :index, :new, :create, :show, :edit, :update]
  resources :customers, only: [ :index, :show, :edit, :update]
end

end
