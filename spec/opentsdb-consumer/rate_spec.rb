require 'spec_helper'

RSpec.describe OpenTSDBConsumer::Rate do
  describe '#to_s' do
    subject { described_class.new(options).to_s }

    context 'without options' do
      let(:options) { {} }

      it { should eq 'rate' }
    end

    context 'with options' do
      let(:options) { { counter: true, counterMax: 1337 } }

      it { should eq 'rate:rateOptions{counter=true,counterMax=1337}' }
    end
  end

  describe '#to_h' do
    let(:options) { {} }

    subject { described_class.new(options).to_h }

    it { should eq({ rate: true }) }

    context 'with options' do
      let(:options) { { counter: true, counterMax: 1337, resetValue: 100 } }

      it do
        should eq ({
          rate: true,
          rateOptions: options,
        })
      end
    end
  end
end
