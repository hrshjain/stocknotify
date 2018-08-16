module UpdateTable
  # Following class will set up dates table
  class UpdateBimonthlyDates

    def self.update_bimonthly_date_table
      return if Date.current == BimonthlyDate&.first&.value
      BimonthlyDate.destroy_all
      BimonthlyDate.create!(value: Date.current)
      if BimonthlyDate.last.value.strftime("%d").to_i > 15
        BimonthlyDate.create!(value: BimonthlyDate.last.value.at_beginning_of_month.advance(weeks:2))
      else
        BimonthlyDate.create!(value: BimonthlyDate.last.value.at_beginning_of_month)
      end
      set_remaining_dates
    end

    def self.set_remaining_dates
      24.times do
        if BimonthlyDate.last.value.strftime("%d").to_i == 15
          BimonthlyDate.create!(value: BimonthlyDate.last.value.at_beginning_of_month)
        elsif BimonthlyDate.last.value.strftime("%d").to_i == 1
          BimonthlyDate.create!(value: (BimonthlyDate.last.value - 1.month).advance(weeks:2))
        end
      end
    end
  end
end
