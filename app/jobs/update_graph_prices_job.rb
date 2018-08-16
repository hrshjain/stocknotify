class UpdateGraphPricesJob < ApplicationJob
  queue_as :default

  def perform_now(*args)
    # Do something later
    ::UpdateTable::UpdateBimonthlyDates.update_bimonthly_date_table
    sleep 1
    ::UpdateTable::UpdateBimonthlyPrices.assign_values
  end
end
