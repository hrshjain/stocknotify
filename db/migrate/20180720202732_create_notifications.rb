class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :stock_symbol
      t.string :stock_name
      t.float :current_stock_price
      t.float :lower_limit
      t.float :upper_limit
      t.boolean :enable_email_notification
      t.boolean :enable_sms_notification

      t.timestamps
    end
  end
end
