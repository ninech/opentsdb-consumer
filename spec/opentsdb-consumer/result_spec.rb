require 'spec_helper'
require 'opentsdb-consumer/result'

RSpec.describe OpenTSDBConsumer::Result do
  describe '.initialize' do
    it 'initializes all variables' do
      result = described_class.new 'metric' => 'my.metric',
                                   'tags' => {},
                                   'aggregateTags' => [],
                                   'dps' => [{ '1' => 2 }]

      expect(result.metric_name).to eq 'my.metric'
      expect(result.tags).to eq({})
      expect(result.aggregate_tags).to eq []
      expect(result.datapoints).to eq [{ '1' => 2 }]
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

    it 'returns an empty result object when there is no data' do
      response = []
      result = described_class.build(response)
      expect(result).to be_a OpenTSDBConsumer::Result
      expect(result.datapoints).to be_an Array
      expect(result.datapoints).to be_empty
    end
  end

  describe '#latest_value' do
    it 'returns to newest value in the series' do
      result = OpenTSDBConsumer::Result.new 'dps' => { '111' => 1, '333' => 3, '222' => 2 }
      expect(result.latest_value).to eq(3)
    end

    it 'returns nil when no datapoints are found' do
      result = OpenTSDBConsumer::Result.new 'dps' => {}
      expect(result.latest_value).to be_nil
    end
  end

  describe '#empty?' do
    it 'returns false when there is data' do
      result = described_class.new 'dps' => [{}]
      expect(result).to_not be_empty
    end

    it 'returns true when there is no data' do
      result = described_class.new 'dps' => []
      expect(result).to be_empty
    end

    it 'returns true when the datapoints are nil' do
      result = described_class.new 'dps' => nil
      expect(result).to be_empty
    end
  end
end
