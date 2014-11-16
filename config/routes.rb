RaveMachine::Application.routes.draw do
  root 'events#index'

  resources :events
  get 'poll_events', to: 'events#poll_events', as: 'poll_events'
end
