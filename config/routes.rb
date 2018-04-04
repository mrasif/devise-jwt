Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  namespace :api do
    post 'register.json' => 'auth#register'
    post 'login.json' => 'auth#login'
    post 'logout.json' => 'auth#logout'
    get 'home.json' => 'home#index'
  end
end
