Scriptverwaltung::Application.routes.draw do
  root :to => "scripts#index"
  resources :comments, only: [:create, :destroy]

  get "users/:id" => "users#show", as: "show_user"
  delete "users/:id" => "users#destroy", as: "destroy_user"

  #Provider match
  match "/auth/:provider/callback", :to => "sessions#create"
  match "/auth/failure", :to => "sessions#failure"

  resources :scripts
  get "scripts/:id/download" => "scripts#download", as: "download_script"
  get "scripts/:id/comment" => "comments#new", as: "comment_script"
  get "scripts/:id/makeactiv" => "scripts#makeActiv", as: "activate_script"

  get   "login" => "sessions#new", as: "login"
  delete "logout" => "sessions#destroy", as: "logout"

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
