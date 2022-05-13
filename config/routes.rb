Rails.application.routes.draw do
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :orders
      resources :shoppers
      resources :merchants
      resources :disburses
      resources :imports, only: [:index]

      #post 'disburses/calculate', to: 'disburses#calculate', as: :calculate_disbursements



    end
  end
 #get 'disburses/calculate/:init_date/:end_date', to: 'api/v1/disburses#calculate', as: :calculate_disbursements

  #get 'disburses/calculate/:init_date/:end_date', to: 'api/v1/disburses#calculate', as: :calculate_disbursements

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
