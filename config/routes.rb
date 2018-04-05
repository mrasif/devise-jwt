Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  namespace :api do
    post 'register.json' => 'auth#register'
    post 'login.json' => 'auth#login'
    post 'update_user.json' => 'auth#update_user'
    post 'logout.json' => 'auth#logout'
    get 'home.json' => 'home#index'
    get 'notes.json' => 'notes#index'
    post 'notes.json' => 'notes#create'
    patch 'notes.json' => 'notes#update'
    delete 'notes.json' => 'notes#destroy'
  end
end
