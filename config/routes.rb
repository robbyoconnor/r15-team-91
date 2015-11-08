Rails.application.routes.draw do
  get '/compare/:owner1/:name1/or/:owner2/:name2', to: 'compare#show', as: :compare
  post '/compare', to: 'compare#create', as: :create_compare

  root 'compare#new'
end
