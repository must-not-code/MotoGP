Rails.application.routes.draw do
  root 'main#index'

  post 'signup' => 'main#signup'
  post 'login' => 'main#login'
  post 'quiz' => 'main#quiz'
  get 'rules' => 'main#rules'
end
