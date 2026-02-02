Rails.application.routes.draw do
  scope '/admin' do
    match 'logo_settings', to: 'logo_settings#update', via: [:post, :put]
  end
end
