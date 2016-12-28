Rails.application.routes.draw do
  resources :events, only: [:index]
  resources :meetup_requests, only: [:index, :new]

  post '/meetup_requests', to: "meetup_requests#new_meetup_request"

end
