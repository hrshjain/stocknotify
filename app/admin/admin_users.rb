ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :phone_number
  #controller do
  #  skip_before_action :authenticate_admin_user!, only: :new
  #end
  menu label: "User Information", priority: 3
  breadcrumb do
    [
      link_to('User', 'admin_users')
    ]
  end

  config.clear_action_items!

  action_item only: :index do
    link_to('Create New User', 'admin_users/new')
  end

  index :title => 'User Information' do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :phone_number
    column :email
    column :current_sign_in_at
    # column :sign_in_count
    # column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :phone_number
      row :email
      row :current_sign_in_at
    end
  end


  form :title => 'New User' do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :phone_number
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
