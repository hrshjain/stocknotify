class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.float :current_stock_price
      t.boolean :enabled

      t.timestamps
    end
  end
end
