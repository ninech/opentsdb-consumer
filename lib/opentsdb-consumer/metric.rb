require 'opentsdb-consumer/rate'

module OpenTSDBConsumer
  class Metric
    attr_reader :name, :aggregator, :rate, :downsample, :tags

    def initialize(name: nil, aggregator: 'sum', rate: false, downsample: '10m-avg', tags: {})
      @name = name
      @aggregator = aggregator
      @rate = Rate.new(rate) if rate
      @downsample = downsample
      @tags = tags
    end

    def to_s
      query = tags.any? ? "{#{tags_to_query}}" : ''
      query += ":#{rate}" if rate
      [aggregator, downsample, name].compact.join(':') + query
    end

    def to_h
      hash = {
        aggregator: aggregator,
        downsample: downsample,
        metric: name,
        tags: tags,
      }
      hash.merge! rate.to_h if rate
      hash
    end

    private

    def tags_to_query
      tags.map { |key, value| [key, value].join '=' }.join(',')
    end
  end
end
