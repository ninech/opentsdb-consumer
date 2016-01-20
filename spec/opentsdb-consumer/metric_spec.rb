require 'spec_helper'
require 'opentsdb-consumer/metric'
require 'opentsdb-consumer/rate'

RSpec.describe OpenTSDBConsumer::Metric do
  let(:name) { 'my.metric' }
  let(:aggregator) { 'avg' }
  let(:rate) { false }
  let(:tags) { {} }
  let(:rate) { false }
  let(:downsample) { '1h-avg' }
  let(:metric) do
    described_class.new name: name,
                        aggregator: aggregator,
                        rate: rate,
                        tags: tags,
                        downsample: downsample
  end

  describe '#to_s' do
    subject { metric.to_s }

    context 'without tags' do
      it { should eq 'avg:1h-avg:my.metric' }
    end

    context 'with tags' do
      let(:tags) { { host: 'metrics01', cpu: 0 } }
      it { should eq 'avg:1h-avg:my.metric{host=metrics01,cpu=0}' }
    end

    context 'with rate' do
      let(:rate) { { counter: true } }
      it { should eq 'avg:1h-avg:my.metric:rate:rateOptions{counter=true}' }
    end
  end

  describe '#to_h' do
    subject { metric.to_h }

    it do
      should eq(aggregator: aggregator,
                downsample: downsample,
                metric: name,
                tags: tags)
    end

    context 'with rate options' do
      let(:rate) { { counter: true } }

      it do
        should eq(aggregator: aggregator,
                  downsample: downsample,
                  metric: name,
                  rate: true,
                  rateOptions: {
                    counter: true
                  },
                  tags: tags)
      end
    end
  end
end
