class ComparePricesJob < ApplicationJob
  queue_as :default

  def perform_now(*args)
    Notification.all.each do |notification|
      if notification.current_stock_price > notification.upper_limit
        notification.send_upper_limit_email_sms
      elsif notification.current_stock_price < notification.lower_limit
        notification.send_lower_limit_email_sms
      end
    end
  end
end
