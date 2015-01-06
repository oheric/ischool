Ischool::Application.routes.draw do

  # here we're just making our routes look nicer
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions
  
  get 'users/index' => 'users#index', as: 'users'
  get 'users/new' => 'users#new'
  post 'users/index' => 'users#create' 
  get 'users/show' => 'users#show', as: :show
  post 'users/new_course' => 'users#new_course', as: :new_course

  root 'users#index'

  get 'courses/show' => 'courses#show', as: :courses_show
  post 'courses/new_student' => 'courses#new_student', as: :new_student
  get 'courses/edit' => 'courses#edit', as: :courses_edit
  patch 'courses/update' => 'courses#update'
  delete 'courses/destroy' => 'courses#destroy', as: :courses_destroy

  get 'students/show' => 'students#show', as: :students_show
  post 'students/new_assignment' => 'students#new_assignment', as: :new_assignment

  get 'assignments/show' => 'assignments#show', as: :assignments_show
  post 'assignments/new_photo' => 'assignments#new_photo', as: :new_photo
  # get 'courses/index' => 'courses#index', as: 'courses'
  # get 'courses/new' => 'courses#new', as: 'courses_new'
  # post 'courses/index' => 'courses#create' 
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
