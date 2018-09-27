Rails.application.routes.draw do
  post "/api/nearby", to:"restaurants#nearby"
  post "/api/rating", to:"restaurants#rating"
  post "/api", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
