class Fronius
  class API
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def get(endpoint, params = {})
      connection.get(endpoint, params).body
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.options.timeout = 10
        conn.url_prefix = url_prefix
        conn.adapter :net_http
        conn.response :json
        conn.headers["Accept-Language"] = "pl"
        conn.headers["accept"] = "application/json"
      end
    end

    def url_prefix
      "#{url}/solar_api/v1/"
    end
  end
end
