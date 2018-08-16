class EmailUnsubscribeMailer < ApplicationMailer
	def unsubscription_email(email, first_name, stock_symbol)

	@email = email
	@stock_symbol = stock_symbol
	@first_name = first_name
    mail(to: email, subject: "Unsubscription Success")
  end
end
