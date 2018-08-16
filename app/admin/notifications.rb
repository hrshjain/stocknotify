ActiveAdmin.register Notification do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
#
before_create do |notification|
  notification.admin_user_id = current_admin_user.id
end

menu priority: 3

permit_params :title, :stock_symbol, :stock_name, :lower_limit, :upper_limit, :enable_email_notification, :enable_sms_notification, :admin_user_id

breadcrumb do
    [
      link_to('User', 'admin_users')
    ]
end

def has_internet?
  require "resolv"
  dns_resolver = Resolv::DNS.new()
  begin
    dns_resolver.getaddress("symbolics.com")
    return true
  rescue Resolv::ResolvError => e
    return false
  end
end

if has_internet?
  sidebar "Top Ten Stock for 2018", only: [:new, :edit], partial: 'custom'
else
  sidebar "Top Ten Stock for 2018", only: [:new, :edit], partial: 'nointernet'
end


index :title => 'Stock Notifications' do
  selectable_column
  # id_column
  column :stock_symbol
  column :stock_name
  column :current_stock_price
  column :lower_limit
  column :upper_limit
  column :enable_email_notification
  column :enable_sms_notification
  #index :title => 'hahah'
  actions
end

show do
  attributes_table do
    row :stock_symbol
    row :stock_name
    row :current_stock_price
    row :lower_limit
    row :upper_limit
    row :enable_email_notification
    row :enable_sms_notification
    row :created_at
    row :updated_at
    row :admin_user
  end
end

form do |f|
  f.inputs do
    f.input :stock_symbol
    f.input :stock_name , input_html: { :readonly => true, disabled: true  }
    f.input :current_stock_price, input_html: { :readonly => true, disabled: true }
    f.input :lower_limit
    f.input :upper_limit
    f.input :enable_email_notification
    f.input :enable_sms_notification
  end
  f.actions
end

end
