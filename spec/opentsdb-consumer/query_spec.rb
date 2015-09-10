require 'spec_helper'

RSpec.describe OpenTSDBConsumer::Query do
  let(:metric) { OpenTSDBConsumer::Metric.new name: 'my.metric' }
  let(:client) { instance_double 'OpenTSDBConsumer::Client', get: mock_response }
  let(:query) { described_class.new metric, client }
  let(:status) { 200 }
  let(:response_body) { '[{}]' }
  let(:mock_response) { instance_double 'Excon::Response', status: status, body: response_body }

  describe '#run' do
    context 'successfuly' do
      it 'queries the server for the given metric' do
        expect(client).to receive(:get).
          with(query: { m: metric, start: '1h-ago' }).
          and_return(mock_response)
        query.run
      end

      it 'allows to set a start time' do
        expect(client).to receive(:get).
          with(query: { m: metric, start: '24h-ago' }).
          and_return(mock_response)
        query.run start: '24h-ago'
      end

      it 'returns the parsed body' do
        expect(client).to receive(:get).and_return(mock_response)
        expect(query.run).to be_a Hash
      end
    end

    context 'invalid metric' do
      let(:status) { 400 }
      let(:response_body) do
        %({"error":{"code":400,"message":"No such name for 'metrics': '#{metric.name}'"}})
      end

      it 'raises an error' do
        expect { query.run }.to raise_exception OpenTSDBConsumer::QueryError
      end
    end
  end
end
