RaveMachine::Application.routes.draw do
  devise_for :users
  root 'events#index'

  resources :events
  get 'poll_events', to: 'events#poll_events', as: 'poll_events'
end
