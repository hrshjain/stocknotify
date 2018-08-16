class CreateBimonthlyDates < ActiveRecord::Migration[5.1]
  def change
    create_table :bimonthly_dates do |t|
      t.date :value

      t.timestamps
    end
  end
end
