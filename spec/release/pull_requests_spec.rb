require './spec/spec_helper'

RSpec.describe PullRequests do
  let(:github) { class_double(Github) }
  let(:organization) { 'openfoodfoundation' }
  let(:repository) { 'openfoodnetwork' }

  let(:pull_requests) { PullRequests.new(github, organization, repository) }

  context 'when passing the since argument' do
    let(:search) { instance_double(Github::Client::Search) }
    let(:github) { class_double(Github, search: search) }

    let(:body) { double(:body, items: [1, 2]) }
    let(:response) { double(:response, body: body) }

    before do
      allow(search)
        .to receive(:issues)
        .with('is:pr repo:openfoodfoundation/openfoodnetwork merged:>2019-01-16')
        .and_return(response)
    end

    it 'fetches pull requests merged since the specified date' do
      pull_requests.get('2019-01-16')

      expect(github.search).to have_received(:issues).with(
        'is:pr repo:openfoodfoundation/openfoodnetwork merged:>2019-01-16'
      )
    end

    it 'returns the matching pull requests objects' do
      objects = pull_requests.get('2019-01-16')
      expect(objects).to eq([1, 2])
    end
  end

  context 'when the since argument is not passed' do
    it 'raises' do
      expect { pull_requests.get }.to raise_error(ArgumentError)
    end
  end
end
