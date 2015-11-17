require 'spec_helper'

RSpec.describe OpenTSDBConsumer::Query do
  let(:metric) { OpenTSDBConsumer::Metric.new name: 'my.metric' }
  let(:client) { instance_double 'OpenTSDBConsumer::Client', post: mock_response }
  let(:query) { described_class.new metric, client }
  let(:status) { 200 }
  let(:response_body) { '[{}]' }
  let(:mock_response) { instance_double 'Excon::Response', status: status, body: response_body }
  let(:expected_query) do
    { aggregator: 'sum', downsample: '10m-avg', metric: 'my.metric', rate: false, tags: {} }
  end

  describe '#run' do
    context 'successfuly' do
      it 'queries the server for the given metric' do
        expect(client).to receive(:post).
          with(body: { start: '1h-ago', queries: [expected_query] }.to_json).
          and_return(mock_response)
        query.run
      end

      it 'allows to set a start time' do
        expect(client).to receive(:post).
          with(body: { start: '24h-ago', queries: [expected_query] }.to_json).
          and_return(mock_response)
        query.run start: '24h-ago'
      end

      it 'returns the parsed body' do
        expect(client).to receive(:post).and_return(mock_response)
        expect(query.run).to be_a OpenTSDBConsumer::Result
      end
    end

    context 'invalid metric' do
      let(:status) { 400 }
      let(:response_body) do
        %({"error":{"code":400,"message":"No such name for 'metrics': '#{metric.name}'"}})
      end

      it 'raises the appropriate error' do
        expect { query.run }.to raise_exception OpenTSDBConsumer::InvalidMetric
      end
    end

    context 'invalid tag' do
      let(:status) { 400 }
      let(:response_body) do
        %({"error":{"code":400,"message":"No such name for 'tagv': 'pony-01'"}})
      end

      it 'raises the appropriate error' do
        expect { query.run }.to raise_exception OpenTSDBConsumer::InvalidTag
      end
    end
  end
end
