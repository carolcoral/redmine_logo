Rails.application.routes.draw do
  scope '/admin' do
    resources :logo_settings, only: [:index, :update], controller: 'logo_settings'
  end
end
