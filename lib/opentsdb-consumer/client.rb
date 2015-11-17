require 'excon'
require 'forwardable'

module OpenTSDBConsumer
  class Client
    extend Forwardable
    attr_reader :host, :port, :connection

    delegate get:  :connection
    delegate post: :connection

    def initialize(host: 'localhost', port: 4242, options: {})
      @host = host
      @port = port
      @connection = Excon.new url, options
    end

    def url
      "http://#{host}:#{port}/api/query"
    end
  end
end
