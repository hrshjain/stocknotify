namespace :update_stock_table do
  desc "Call Alphavantage API and update Stock table with latest prices"

  task task1: :environment do
    CallAplphavantageApiJob.perform_now
  end

  task task2: :environment do
    ComparePricesJob.perform_now
  end

  task task3: :environment do
    UpdateGraphPricesJob.perform_now
  end

end
