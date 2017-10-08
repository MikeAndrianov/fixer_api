module FixerApi
  class Request
    FIXER_API_URL = 'http://api.fixer.io'.freeze

    def initialize(path, params = {})
      @path = path
      @params = params
    end

    def perform
      response = JSON(make_request)

      check!(response.to_s)
    end

    private

    def make_request
      Net::HTTP.get(url)
    end

    def url
      uri = URI.parse("#{FIXER_API_URL}/#{@path}")
      uri.query = URI.encode_www_form(params) if @params.present?
    end

    def check!(response)
      fail ResponseError unless response.include?('rates')

      response
    end
  end
end
