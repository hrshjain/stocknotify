module UpdateTable
  # Following class will set up dates table
  class UpdateBimonthlyPrices

    def self.assign_values
      Stock.all.each do |stock|
        begin
          iexarray = IEX::Resources::Chart.get(stock.symbol, '1y').select { |item| BimonthlyDate.all.pluck("value").include? (item.date)}
        rescue
          Rails.logger.info("iex value not valid")
          next
        end
          iexarray.each do |iexobject|
          begin
            BimonthlyDateStockPrice.create!(
                price: iexobject.close,
                bimonthly_date_id: BimonthlyDate.where(value: iexobject.date)&.first&.id,
                stock_id: stock.id)
          rescue
            Rails.logger.info("company name not retrived")
          end
        end
      end
    end

    # def iexarray2(sym)
    #   IEX::Resources::Chart.get(sym, '1y').select { |item| BimonthlyDate.all.pluck("value").include? (item.date)}
    # end
  end
end
