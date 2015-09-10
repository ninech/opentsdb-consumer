require 'json'

module OpenTSDBConsumer
  class Query
    attr_accessor :metric, :client

    def initialize(metric, client)
      @metric = metric
      @client = client
    end

    def run(start: '1h-ago')
      response = client.get query: { m: metric, start: start }
      parsed_body = JSON.parse(response.body)
      return parsed_body.first if response.status < 400

      fail QueryError, parsed_body['error']['message']
    end
  end
end
