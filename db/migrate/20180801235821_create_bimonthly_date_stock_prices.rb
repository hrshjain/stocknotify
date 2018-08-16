class CreateBimonthlyDateStockPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :bimonthly_date_stock_prices do |t|
      t.float :price
      t.references :bimonthly_date, foreign_key: true
      t.references :stock, foreign_key: true

      t.timestamps
    end
  end
end
