Rails.application.routes.draw do
  post "/api", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace :api do
  #   namespace :v1 do
  #     resources :restaurants
  #   end
  # end
  # resources :restaurants
end
