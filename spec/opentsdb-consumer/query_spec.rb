require 'spec_helper'

RSpec.describe OpenTSDBConsumer::Query do
  let(:metric) { OpenTSDBConsumer::Metric.new name: 'my.metric' }
  let(:client) { instance_double 'OpenTSDBConsumer::Client' }
  let(:query) { described_class.new metric, client }

  describe '#run' do
    it 'queries the server for the given metric' do
      expect(client).to receive(:get).with(query: { m: metric, start: '1h-ago' })
      query.run
    end

    it 'allows to set a start time' do
      expect(client).to receive(:get).with(query: { m: metric, start: '24h-ago' })
      query.run start: '24h-ago'
    end
  end
end
