Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks',
                                   registrations: 'users/registrations'}
  root 'static_pages#home'
end
