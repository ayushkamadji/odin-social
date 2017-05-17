Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks',
                                   registrations: 'users/registrations'}
  devise_scope :user do
    get '/', to: 'static_pages#home'
  end

  root 'static_pages#home'

  resources :users, only: [:show]
end
