Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#home"

  get 'invitations', to: 'dashboard#invitation'
  get 'accept_invitation', to: 'dashboard#accept_invitation'
  get 'reject_invitation', to: 'dashboard#reject_invitation'

  resources :events do
  	resources :invitations
  end
end
