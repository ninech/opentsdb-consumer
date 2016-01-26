module OpenTSDBConsumer
  class QueryError < StandardError; end

  class InvalidMetric < QueryError; end
  class InvalidTag < QueryError; end
  class EmptyTag < InvalidTag; end
end
