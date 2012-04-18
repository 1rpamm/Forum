# -*- encoding : utf-8 -*-
Forum::Application.routes.draw do

  get "tags/index"

  get "tags/show"

  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

  resources :topics do
    resources :posts
  end
  resources :users, :except => [:edit, :update]
  resources :sessions
  resources :tags, :only => [:index]

  # The priority is based upon order of creation:
  # first created -> highest priority.
  match 'logout' => "sessions#destroy", :as => :logout
  match 'profile' => "users#edit", :as => :profile
  match 'update_avatar' => "users#update_avatar", :as => :update_avatar
  match 'update_password' => "users#update_password", :as => :update_password
  match 'update_sign' => "users#update_sign", :as => :update_sign
  match 'update_sex' => "users#update_sex", :as => :update_sex
  match 'update_birthday' => "users#update_birthday", :as => :update_birthday
  match 'tags/:name' => "tags#show", :as => :show_tag
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'topics#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
