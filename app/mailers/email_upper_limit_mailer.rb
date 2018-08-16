class EmailUpperLimitMailer < ApplicationMailer
	def overlimit_email(email, first_name, stock_symbol, upper_limit, current_stock_price)

	@email = email
	@stock_symbol = stock_symbol
	@upper_limit = upper_limit
	@current_stock_price = current_stock_price
	@first_name = first_name
    mail(to: email, subject: "Stock Price Exceeded Limit")
  end
end
