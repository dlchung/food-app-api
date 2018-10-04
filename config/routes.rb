Rails.application.routes.draw do
  post "/api/nearby", to:"restaurants#nearby"
  post "/api/rating", to:"restaurants#rating"
  post "/api/locations/create", to:"locations#create"
  post "/api/locations/delete", to:"locations#delete"
  get "/api/locations/get_locations", to:"locations#get_locations"
  post "/api", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
