Rails.application.routes.draw do
  post "/api", to: "graphql#execute"
  post "/api/nearby", to:"restaurants#nearby"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
