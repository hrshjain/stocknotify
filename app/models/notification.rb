require 'twilio-ruby'

class Notification < ApplicationRecord
  belongs_to :admin_user

  validates :upper_limit, numericality: true, :allow_nil => true
  validates :lower_limit, numericality: true, :allow_nil => true
  validate :low_limit
  before_save :create_new_stock_record, :first_api_call, :get_stockname
  before_save :send_subscription_email_sms, :update_bimonthly_date_prices,  if: :manual_attriubute_changed?
  before_destroy :send_unsubscribe_email_sms

  def manual_attriubute_changed?
    will_save_change_to_stock_symbol? || will_save_change_to_lower_limit? || \
    will_save_change_to_upper_limit? || will_save_change_to_enable_email_notification?
  end

  def low_limit
    if upper_limit != nil && lower_limit !=nil && upper_limit < lower_limit
      errors.add(:lower_limit, 'Lower limit should be less than Upper limit')
    end
  end

  def create_new_stock_record
    return if Stock.find_by_symbol(self[:stock_symbol])
    Stock.create!(symbol: self[:stock_symbol], enabled: true)
  end

  def first_api_call
    self[:current_stock_price] = IEX::Resources::Quote.get(self[:stock_symbol]).latest_price
  rescue
    Rails.logger.info("notification will not be sent for this symbol")
  end

  def get_stockname
    self[:stock_name] = IEX::Resources::Company.get(self[:stock_symbol]).company_name
  rescue
    Rails.logger.info("company name not retrived")
  end

  def send_subscription_email_sms
    EmailSubscribeMailer.subscription_email(AdminUser.find(self[:admin_user_id]).email, AdminUser.find(self[:admin_user_id]).first_name, self[:stock_symbol]).deliver_now if self[:enable_email_notification]

    if self[:enable_sms_notification]
      begin
        @client = Twilio::REST::Client.new(account_sid, auth_token)
        @client.messages.create(
            from: '+17784003755',
            body: "StockNotify Alert: You are now subscribed to #{self[:stock_symbol]} with limits between "\
                  "#{stock_lower_limit} and #{stock_upper_limit}. The current stock price is #{stock_price_sms}",
            to: AdminUser.find(self[:admin_user_id]).phone_number
        )
      rescue
        Rails.logger.info("Can't connect to Twilio as we are using Twilio Trial account")
      end
    end
  end

  def send_unsubscribe_email_sms
    EmailUnsubscribeMailer.unsubscription_email(AdminUser.find(self[:admin_user_id]).email, AdminUser.find(self[:admin_user_id]).first_name, self[:stock_symbol]).deliver_now
    if self[:enable_sms_notification]
      begin
        @client = Twilio::REST::Client.new(account_sid, auth_token)
        @client.messages.create(
            from: '+17784003755',
            body: "StockNotify Alert: You now have been unsubscribed from #{self[:stock_symbol]}",
            to: AdminUser.find(self[:admin_user_id]).phone_number
        )
      rescue
        Rails.logger.info("Can't connect to Twilio as we are using Twilio Trial account")
      end
    end
  end

  def send_upper_limit_email_sms
    if self[:enable_email_notification]
      EmailUpperLimitMailer.overlimit_email(AdminUser.find(self[:admin_user_id]).email,AdminUser.find(self[:admin_user_id]).first_name, self[:stock_symbol], self[:upper_limit], self[:current_stock_price]).deliver_now
      update_column(:enable_email_notification, false)
    end

    if self[:enable_sms_notification]
      update_column(:enable_sms_notification, false)
      begin
        @client = Twilio::REST::Client.new(account_sid, auth_token)
        @client.messages.create(
            from: '+17784003755',
            body: "#{self[:stock_symbol]} Stock Alert: Your stock has gone over the upper limit of #{self[:upper_limit]}. The current stock price is #{self[:current_stock_price]}. Please manage this in your account.",
            to: AdminUser.find(self[:admin_user_id]).phone_number
        )
      rescue
        Rails.logger.info("Can't connect to Twilio as we are using Twilio Trial account")
      end
    end
  end

  def send_lower_limit_email_sms
    if self[:enable_email_notification]
      EmailLowerLimitMailer.underlimit_email(AdminUser.find(self[:admin_user_id]).email, AdminUser.find(self[:admin_user_id]).first_name, self[:stock_symbol], self[:lower_limit], self[:current_stock_price]).deliver_now
      update_column(:enable_email_notification, false)
    end

    if self[:enable_sms_notification]
      update_column(:enable_sms_notification, false)
      begin
        @client = Twilio::REST::Client.new(account_sid, auth_token)
        @client.messages.create(
            from: '+17784003755',
            body: "#{self[:stock_symbol]} Stock Alert: Your stock has dived under the lower limit of #{self[:lower_limit]}. The current stock price is #{self[:current_stock_price]}. Please manage this in your account.",
            to: AdminUser.find(self[:admin_user_id]).phone_number
        )
      rescue
        Rails.logger.info("Can't connect to Twilio as we are using Twilio Trial account")
      end
    end
  end

  def update_bimonthly_date_prices
    ::UpdateTable::UpdateBimonthlyDates.update_bimonthly_date_table
    sleep 1
    ::UpdateTable::UpdateBimonthlyPrices.assign_values
  end

  def stock_price_sms
    ApplicationController.helpers.number_to_currency(self[:current_stock_price])
  end

  def stock_upper_limit
    ApplicationController.helpers.number_to_currency(self[:upper_limit])
  end


  def stock_lower_limit
    ApplicationController.helpers.number_to_currency(self[:lower_limit])
  end

end
