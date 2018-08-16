class CallAplphavantageApiJob < ApplicationJob
  queue_as :default

  def perform_now(*args)
    Stock.all.each do |stock|
      begin
        stock.update_attribute(:current_stock_price, IEX::Resources::Quote.get(stock.symbol).latest_price)
      rescue
        puts 'error'
      end
    end
  end
end
