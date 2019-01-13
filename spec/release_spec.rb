require './lib/release'
require './spec/spec_helper'

RSpec.describe Release do
  describe '#last_release_version' do
    it 'returns the name of the latest release' do
      release = described_class.new
      expect(release.last_release_version).to eq('v1.25.0')
    end
  end
end
