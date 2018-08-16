class EmailLowerLimitMailer < ApplicationMailer
	def underlimit_email(email, first_name, stock_symbol, lower_limit, current_stock_price)

	@email = email
	@stock_symbol = stock_symbol
	@lower_limit = lower_limit
	@current_stock_price = current_stock_price
	@first_name = first_name
    mail(to: email, subject: "Stock Price Below Limit")
  end
end
