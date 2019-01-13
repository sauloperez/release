require './lib/release'
require './spec/spec_helper'

RSpec.describe Release do
  let(:release) { described_class.new }

  describe '#last_release_version' do
    it 'returns the name of the latest release' do
      stub_request(:get, "#{API_URL}/releases/latest")
        .to_return(body: '{"tag_name": "v1.25.0"}')

      expect(release.last_release_version).to eq('v1.25.0')
    end
  end

  describe '#release_note' do
    it 'returns the release note of a pull request' do
      text = <<-TEXT
Some description

#### Release notes

A note
TEXT
      response_body = { body: text }

      stub_request(:get, "#{API_URL}/pulls/1")
        .to_return(body: response_body.to_json)

      expect(release.release_note(1)).to eq('A note')
    end
  end
end
