require 'excon'

module OpenTSDBConsumer
  class Client
    attr_reader :host, :port, :connection

    def initialize(host: 'localhost', port: 4242, options: {})
      @host = host
      @port = port
      @connection = Excon.new url, options
    end

    def get(params)
      connection.get params
    end

    def url
      "http://#{host}:#{port}/api/query"
    end
  end
end
