module OpenTSDBConsumer
  class QueryError < StandardError; end

  class InvalidMetric < QueryError; end
  class InvalidTag < QueryError; end
end
