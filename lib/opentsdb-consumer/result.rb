module OpenTSDBConsumer
  class Result
    attr_reader :metric_name, :tags, :aggregate_tags, :datapoints

    def initialize(response)
      @metric_name = response['metric']
      @tags = response['tags']
      @aggregate_tags = response['aggregateTags']
      @datapoints = response['dps']
    end

    def self.build(response)
      results = response.map { |h| new(h) }
      case results.length
      when 0
        new('dps' => [])
      when 1
        results.first
      else
        results
      end
    end

    def latest_value
      datapoint = datapoints.max_by { |timestamp, _| timestamp }
      datapoint.last if datapoint
    end

    def empty?
      datapoints.nil? || datapoints.empty?
    end
  end
end
