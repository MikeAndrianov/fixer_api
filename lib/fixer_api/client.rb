module FixerApi
  class Client
    RETRIES_COUNT = 4

    class << self
      def get_rates_for_period(date_from, date_to, params = {})
        (date_from..date_to).map { |date| get_rates_for_day(date, params) }
      end

      def get_rates_for_day(date, params = {})
        return if date > Date.today

        begin
          retries ||= 0

          Request.new(date.to_s, params).perform
        rescue ResponseError
          sleep(5 * (retries + 1))

          retry if (retries += 1) < RETRIES_COUNT
        end
      end
    end
  end
end
