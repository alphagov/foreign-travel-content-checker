# frozen_string_literal: true

Rails.application.routes.draw do
  get "/location/:slug", to: "locations#show", as: "location"
  get "/locations/update", to: "locations#update", as: "update"
  get "/locations/completed", to: "locations#completed", as: "completed", defaults: { format: "json" }

  root "locations#index"
end
