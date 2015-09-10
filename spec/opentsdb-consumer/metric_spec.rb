require 'spec_helper'
require 'opentsdb-consumer/metric'

RSpec.describe OpenTSDBConsumer::Metric do
  let(:name) { 'my.metric' }
  let(:aggregator) { 'avg' }
  let(:rate) { false }
  let(:tags) { {} }
  let(:metric) { described_class.new name: name, aggregator: aggregator, rate: rate, tags: tags }

  describe '#to_s' do
    subject { metric.to_s }

    context 'without tags' do
      it { should eq 'avg:my.metric' }
    end

    context 'with tags' do
      let(:tags) { { host: 'metrics01', cpu: 0 } }
      it { should eq 'avg:my.metric{host=metrics01,cpu=0}' }
    end

    context 'with rate' do
      let(:rate) { true }
      it { should eq 'avg:rate:my.metric' }
    end
  end
end
