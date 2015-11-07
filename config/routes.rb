Rails.application.routes.draw do
  resource :compare, controller: 'compare'
  root 'compare#index'
end
