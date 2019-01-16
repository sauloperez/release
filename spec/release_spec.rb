require './lib/release'
require './spec/spec_helper'

RSpec.describe Release do
  let(:release) { described_class.new(GITHUB_OFN_ORGANIZATION, GITHUB_OFN_REPOSITORY) }

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

  describe '#pull_requests' do
    context 'when since argument is not passed' do
      it 'raises' do
        expect { release.pull_requests }.to raise_error(ArgumentError)
      end
    end

    context 'when since argument is passed' do
      it 'returns the numbers of the pull requests' do
        response_body = {
          items: [
            { number: 3280 },
            { number: 3115 },
            { number: 3072 }
          ]
        }.to_json

        stub_request(:get, 'https://api.github.com/search/issues?q=is:pr%20repo:openfoodfoundation/openfoodnetwork%20merged:%3E2019-01-10')
          .to_return(status: 200, body: response_body, headers: {})

        expect(release.pull_requests(since: '2019-01-10')).to eq([3280, 3115, 3072])
      end
    end
  end
end
