class AddAdminUserToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :admin_user, foreign_key: true
  end
end
