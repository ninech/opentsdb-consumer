require 'spec_helper'
require 'opentsdb-consumer/result'

RSpec.describe OpenTSDBConsumer::Result do
  describe '.initialize' do
    it 'initializes all variables' do
      result = described_class.new 'metric' => 'my.metric',
                                   'tags' => {},
                                   'aggregateTags' => [],
                                   'dps' => [{ '1': 2 }]

      expect(result.metric_name).to eq 'my.metric'
      expect(result.tags).to eq({})
      expect(result.aggregate_tags).to eq []
      expect(result.datapoints).to eq [{ '1': 2 }]
    end
  end

  describe '.build' do
    it 'builds a result object from a query response' do
      response = [{}]
      expect(described_class.build(response)).to be_a OpenTSDBConsumer::Result
    end

    it 'returns an array of result objects when there are many' do
      response = [{}, {}]
      results = described_class.build(response)
      expect(results).to be_a Array
      expect(results.first).to be_a OpenTSDBConsumer::Result
      expect(results.last).to be_a OpenTSDBConsumer::Result
    end
  end
end
