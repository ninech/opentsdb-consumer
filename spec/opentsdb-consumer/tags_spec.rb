require 'spec_helper'

RSpec.describe OpenTSDBConsumer::Tags do
  let(:tags) { { key: 'value' } }

  describe '#new' do
    context 'with empty tag' do
      it 'throws EmptyTag exception' do
        expect do
          described_class.new(key: '')
        end.to raise_error OpenTSDBConsumer::EmptyTag
      end
    end
  end

  describe '#to_h' do
    subject { described_class.new(tags).to_h }

    it { is_expected.to eq ({ key: 'value' }) }
  end

  describe '#to_s' do
    subject { described_class.new(tags).to_s }

    it { is_expected.to eq 'key=value' }
  end

  describe '#any?' do
    subject { described_class.new(tags).any? }

    it { is_expected.to be true }
  end
end
