module FixerApi
  class Client
    class << self
      def get_rates_for_period(date_from, date_to, params = {})
        (date_from..date_to).map { |date| get_rates_for_day(date, params) }
      end

      def get_rates_for_day(date, params = {})
        Request.new(date.to_s, params).perform
      end
    end
  end
end
