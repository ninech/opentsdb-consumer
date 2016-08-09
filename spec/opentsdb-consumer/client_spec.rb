require 'spec_helper'

RSpec.describe OpenTSDBConsumer::Client do
  let(:host)         { 'myhost.com' }
  let(:port)         { 4243 }
  let(:metric_names) { %w(metric1 metric2) }

  subject { described_class.new(host: host, port: port) }

  describe '#url' do
    subject { super().url }

    it 'assembles a correct url for opentsdb requests' do
      expect(subject).to eq 'http://myhost.com:4243/api/query'
    end
  end

  describe '#fetch' do
    subject do
      super().fetch(metric_names, aggregator: 'cubic', start: 'now', unknown_key: 'not here')
    end

    before(:each) do
      query_double = instance_double(OpenTSDBConsumer::Query)
      allow(query_double).to receive(:run)
      allow(OpenTSDBConsumer::Query).to receive(:new).and_return(query_double)
    end

    describe 'components' do
      it 'uses OpenTSDB metric' do
        expect(OpenTSDBConsumer::Metric).to receive(:new).with(
          aggregator: 'cubic', downsample: '5m-avg', rate: false, tags: {}, name: 'metric1'
        )

        expect(OpenTSDBConsumer::Metric).to receive(:new).with(
          aggregator: 'cubic', downsample: '5m-avg', rate: false, tags: {}, name: 'metric2'
        )

        subject
      end

      describe 'OpenTSDB query' do
        it 'uses OpenTSDB query' do
          fake_metric = double('fake_metric')

          allow(OpenTSDBConsumer::Metric).to receive(:new).and_return(fake_metric)

          expect(OpenTSDBConsumer::Query).to receive(:new).with([fake_metric, fake_metric], any_args)

          subject
        end

        it 'makes a query to OpenTSDB backend' do
          fake_query = double('fake_query')

          allow(OpenTSDBConsumer::Query).to receive(:new).and_return(fake_query)

          expect(fake_query).to receive(:run).with(start: 'now')

          subject
        end

        it 'let exceptions bubble up' do
          fake_query = double('fake_query')

          allow(fake_query).to receive(:run).and_raise(OpenTSDBConsumer::InvalidMetric)
          allow(OpenTSDBConsumer::Query).to receive(:new).and_return(fake_query)

          expect { subject.datapoints }.to raise_error(OpenTSDBConsumer::InvalidMetric)
        end
      end
    end
  end
end
