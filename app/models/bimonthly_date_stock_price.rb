class BimonthlyDateStockPrice < ApplicationRecord
  belongs_to :bimonthly_date
  belongs_to :stock
end
