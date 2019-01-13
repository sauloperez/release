require './lib/release'
require './spec/spec_helper'

RSpec.describe Release do
  describe '#call' do
    it 'returns the name of the latest release' do
      release = described_class.new
      expect(release.call).to eq('v1.25.0 Artichoke')
    end
  end
end
