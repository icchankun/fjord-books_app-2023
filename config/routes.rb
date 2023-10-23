Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'

  concern :commentable do
    resources :comments, only: %i(create destroy)
  end

  resources :books, concerns: :commentable
  resources :users, only: %i(index show)
  resources :reports, concerns: :commentable
end
