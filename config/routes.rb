Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'ratings/create'
    end
  end

  namespace :api do
    namespace :v0 do
      resources :ping, only: [:index], constraints: { format: 'json' }
    end
    namespace :v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      resources :movies, only: [:index, :create, :destroy] do
       resources :reviews, only: [:create, :destroy, :update]
       resources :ratings, only: [:create, :destroy, :update]
      end

      get 'auth/emails'
    end
  end
end
