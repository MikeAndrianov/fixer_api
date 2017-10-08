module FixerApi
  class Client
    class << self
      def get_rates_for_period(date_from, date_to, params = {})
        date_from = date_from.to_s
        date_to = date_to.to_s

        # TODO
      end

      def get_rates_for_day(date, params = {})
        date = date.to_s

        request = Request.new(date, params)
        request.perform
      end
    end
  end
end
