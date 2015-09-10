module OpenTSDBConsumer
  class Query
    attr_accessor :metric, :client

    def initialize(metric, client)
      @metric = metric
      @client = client
    end

    def run(start: '1h-ago')
      client.get query: { m: metric, start: start }
    end
  end
end
