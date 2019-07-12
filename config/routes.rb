Rails.application.routes.draw do
  root 'short_links#new'

  resources :short_links, only: [:new, :create, :show, :update] do
    member do
      get 'admin'
    end
  end
  get 's/:short_url', to: 'short_links#redirect_to_original_url', as: 'redirect_to_original_url'
end
