Rails.application.routes.draw do
  post "tasks/create" => "tasks#create"
  post "tasks/:id/destroy" => "tasks#destroy"
  get "tasks/index" => "tasks#index"
  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/:id" => "users#show"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "login" => "users#login_form"

  get "/" => "home#top"
  get "about" => "home#about"
end
