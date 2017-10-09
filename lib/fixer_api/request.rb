module FixerApi
  class Request
    FIXER_API_URL = 'http://api.fixer.io'.freeze

    def initialize(path, params = {})
      @path = path
      @params = params
    end

    def perform
      response = JSON(make_request)

      check!(response)
    end

    private

    def make_request
      Net::HTTP.get(url)
    end

    def url
      uri = URI.parse("#{FIXER_API_URL}/#{@path}")
      uri.query = URI.encode_www_form(@params) if @params.present?
      uri
    end

    def check!(response)
      raise ResponseError unless response.to_s.include?('rates')

      response
    end
  end
end
