require 'spec_helper'

RSpec.describe OpenTSDBConsumer::Client do
  let(:client) { described_class.new host: 'metrics.local', port: '4243' }

  describe '#url' do
    it 'assembles a correct url for opentsdb requests' do
      expect(client.url).to eq 'http://metrics.local:4243/api/query'
    end
  end
end
