Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  namespace :api do
    namespace :v1 do
      get 'sankey', to: 'database#sankey'
      get 'cyclones', to: 'database#cyclones'
      get 'rainfall', to: 'database#rainfall'
    end
  end
end
