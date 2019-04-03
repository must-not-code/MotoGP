Rails.application.routes.draw do
  root 'main#index'

  post 'signup' => 'main#signup'
  post 'login' => 'main#login'
  post 'quiz' => 'main#quiz'
  post 'reset' => 'main#reset'
  post 'password' => 'main#password'
end
