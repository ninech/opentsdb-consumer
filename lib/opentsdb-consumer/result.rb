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
      results.length > 1 ? results : results.first
    end
  end
end
