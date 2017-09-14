MaroPostForum::Application.routes.draw do

  devise_for :users

  resources :tags

  resources :topics, :except => :index do
    resources :reviews, :except => :show
    member do
      put 'upvote'
      get 'schedule'
      put 'schedule', :to => 'topics#update_schedule'
      get 'project/edit', :to => 'topics#edit_project', :as => 'edit_project'
      put 'project', :to => 'topics#update'
      delete 'project', :to => 'topics#destroy'
    end
    collection do
      get 'general'
      get 'past'
      get 'project'
      get 'project/new', :to => 'topics#new_project', :as => 'new_project'
      post 'project', :to => 'topics#create'
      get 'scheduled'
    end
  end

  get 'reviews/received', :to => 'reviews#received'
  get 'reviews/posted', :to => 'reviews#posted'



  authenticated :user do
    root :to => 'topics#index'
  end

  

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
