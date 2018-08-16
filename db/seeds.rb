# This file should contain all the record creation needed to seed the database with its default values.
# The update_table can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  Notification.create!(stock_symbol: 'FB', lower_limit: 180, upper_limit: 190, enable_email_notification: true,\
                        enable_sms_notification: true, admin_user_id: 1)
  Notification.create!(stock_symbol: 'AAPL', lower_limit: 300, upper_limit: 400, enable_email_notification: true,\
                        enable_sms_notification: true, admin_user_id: 1)
  AdminUser.create!(email: 'ggbaker@sfu.ca', first_name: 'Greg', last_name: 'Baker',phone_number: '+10000000000',\
                    password: 'password', password_confirmation: 'password')
  Notification.create!(stock_symbol: 'FB', lower_limit: 180, upper_limit: 190, enable_email_notification: true,\
                        enable_sms_notification: true, admin_user_id: 2)
  Notification.create!(stock_symbol: 'AAPL', lower_limit: 300, upper_limit: 400, enable_email_notification: true,\
                        enable_sms_notification: true, admin_user_id: 2)
# end
