require 'json'

module OpenTSDBConsumer
  class Query
    attr_accessor :metrics, :client

    def initialize(metrics, client)
      @metrics = [metrics].flatten
      @client = client
    end

    def run(start: '1h-ago')
      response = client.post body: request_body(start)
      parsed_body = JSON.parse(response.body)
      return OpenTSDBConsumer::Result.build(parsed_body) if response.status < 400

      response_message = parsed_body['error']['message']
      fail error_for_response(response_message), response_message
    end

    def latest_value(start: '1m-ago')
      result = run(start: start)
      result.latest_value if result
    end

    private

    def request_body(start)
      { start: start, queries: metrics.map(&:to_h) }.to_json
    end

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
