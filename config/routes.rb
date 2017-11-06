Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/zmog', to: 'application#index', as: 'zmog'
  get '/customers', to: 'customers#index', as: 'customers'
end
