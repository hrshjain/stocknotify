class BimonthlyDate < ApplicationRecord
  has_many :bimonthly_date_stock_prices, dependent: :destroy
end
