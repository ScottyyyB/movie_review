Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :ping, only: [:index], constraints: { format: 'json' }
    end
    namespace :v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      resources :movies, only: [:index, :create, :destroy]
      get 'auth/emails'
    end
  end
end
