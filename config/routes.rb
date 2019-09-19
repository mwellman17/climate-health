Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  namespace :api do
    namespace :v1 do
      get 'sankey', to: 'database#sankey'
    end
  end
end
