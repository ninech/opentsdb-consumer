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
      return OpenTSDBConsumer::Result.build(parsed_body) if response.status < 400

      response_message = parsed_body['error']['message']
      fail error_for_response(response_message), response_message
    end

    private

    def error_for_response(response_message)
      case response_message
      when /^No such name for 'tagv'/
        InvalidTag
      when /^No such name for 'metrics'/
        InvalidMetric
      else
        QueryError
      end
    end
  end
end
