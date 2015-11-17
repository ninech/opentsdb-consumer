module OpenTSDBConsumer
  class Metric
    attr_reader :name, :aggregator, :rate, :downsample, :tags

    def initialize(name: nil, aggregator: 'sum', rate: false, downsample: '10m-avg', tags: {})
      @name = name
      @aggregator = aggregator
      @rate = rate
      @downsample = downsample
      @tags = tags
    end

    def to_s
      query = tags.any? ? "{#{tags_to_query}}" : ''
      [aggregator, downsample, rate_to_query, name].compact.join(':') + query
    end

    def to_h
      {
        aggregator: aggregator,
        downsample: downsample,
        metric: name,
        rate: rate,
        tags: tags,
      }
    end

    private

    def tags_to_query
      tags.map { |key, value| [key, value].join '=' }.join(',')
    end

    def rate_to_query
      'rate' if rate
    end
  end
end
