Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'photos#index'

  resources :photos do
    resources :comments
    member do
      put "like", to: "photos#vote"
    end
  end

end
