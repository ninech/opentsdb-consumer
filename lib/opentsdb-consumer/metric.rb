require 'opentsdb-consumer/rate'

module OpenTSDBConsumer
  class Metric
    ATTRIBUTES_WHITELIST = %i(aggregator rate downsample tags).freeze

    attr_reader :name, :aggregator, :rate, :downsample, :tags

    def initialize(name: nil, aggregator: 'sum', rate: false, downsample: '10m-avg', tags: {})
      @name       = name
      @aggregator = aggregator
      @rate       = Rate.new(rate) if rate
      @downsample = downsample
      @tags       = Tags.new(tags)
    end

    def to_s
      query = tags.any? ? "{#{tags}}" : ''
      query += ":#{rate}" if rate
      [aggregator, downsample, name].compact.join(':') + query
    end

    def to_h
      hash = {
        aggregator: aggregator,
        downsample: downsample,
        metric: name,
        tags: tags.to_h,
      }

      hash.merge! rate.to_h if rate

      hash
    end
  end
end
