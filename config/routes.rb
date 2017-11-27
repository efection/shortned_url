Rails.application.routes.draw do
  root 'short_urls#index'
  resources :short_urls

  get '/:short_url', to: 'short_urls#eject_url'
end
