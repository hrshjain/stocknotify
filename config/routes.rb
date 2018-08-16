Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  root 'admin/dashboard#index' # Source: https://stackoverflow.com/questions/11087362/setting-root-page-to-activeadmin-default-login-page
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
