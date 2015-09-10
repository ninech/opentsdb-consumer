module OpenTSDBConsumer
  class Metric
    attr_reader :name, :aggregator, :rate, :tags

    def initialize(name: nil, aggregator: 'sum', rate: false, tags: {})
      @name = name
      @aggregator = aggregator
      @rate = rate
      @tags = tags
    end

    def to_s
      query = tags.any? ? "{#{tags_to_query}}" : ''
      [aggregator, rate_to_query, name].compact.join(':') + query
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
