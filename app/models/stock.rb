class Stock < ApplicationRecord

  has_many :bimonthly_date_stock_prices, dependent: :destroy


  after_update :update_notification_tables

  def update_notification_tables
    Notification.where(stock_symbol: self[:symbol]).each do |notification|
      notification.update_attribute(:current_stock_price, self[:current_stock_price])
    end
  end

end
