require './spec/spec_helper'

RSpec.describe LatestRelease do
  describe '#tag_name' do
    let(:releases) { double(:releases) }
    let(:repos) { instance_double(Github::Client::Repos, releases: releases) }
    let(:github) { class_double(Github, repos: repos) }

    let(:organization) { 'openfoodfoundation' }
    let(:repository) { 'openfoodnetwork' }

    let(:body) { double(:body, tag_name: 'v1.25.0') }
    let(:response) { double(:response, body: body) }

    before do
      allow(releases)
        .to receive(:latest).with(organization, repository) { response }
    end

    it 'returns the tag name' do
      latest_release = described_class.new(github, organization, repository)
      expect(latest_release.tag_name).to eq('v1.25.0')
    end
  end

  describe '#revision' do
    let(:releases) { double(:releases) }
    let(:repos) { instance_double(Github::Client::Repos, releases: releases) }
    let(:github) { class_double(Github, repos: repos) }

    let(:organization) { 'openfoodfoundation' }
    let(:repository) { 'openfoodnetwork' }

    let(:body) { double(:body, target_commitish: '57267ab4a449b3a64e87c95adab08d392a1de872') }
    let(:response) { double(:response, body: body) }

    before do
      allow(releases)
        .to receive(:latest).with(organization, repository) { response }
    end

    it 'returns the tag name' do
      latest_release = described_class.new(github, organization, repository)
      expect(latest_release.revision).to eq('57267ab4a449b3a64e87c95adab08d392a1de872')
    end
  end
end
