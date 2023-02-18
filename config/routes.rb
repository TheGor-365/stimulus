Rails.application.routes.draw do
  root "addresses#index"

  resources :addresses do
    collection do
      get :states
    end
  end
end
