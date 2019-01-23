require './spec/spec_helper'

RSpec.describe Release::Summary do
  it "prints the passed pull request's html_url attribute" do
    pr_3347 = instance_double(
      Release::PullRequest,
      :pull_request,
      html_url: 'https://github.com/openfoodfoundation/openfoodnetwork/pull/3347',
      number: 3347,
      release_note: 'Note for 3347'
    )
    pr_3339 = instance_double(
      Release::PullRequest,
      :pull_request,
      html_url: 'https://github.com/openfoodfoundation/openfoodnetwork/pull/3339',
      number: 3339,
      release_note: 'Note for 3339'
    )

    text = <<-TEXT
Some description

#### Release notes

A release note
    TEXT
    response_body = double(:response_body, body: text)
    response = double(:response, body: response_body)
    pull_requests = double(:pull_requests)

    allow(pull_requests)
      .to receive(:get)
      .with('openfoodfoundation', 'openfoodnetwork', kind_of(Integer))
      .and_return(response)

    github = double(:github, pull_requests: pull_requests)
    summary = described_class.new(
      github,
      'openfoodfoundation',
      'openfoodnetwork',
      [pr_3347, pr_3339]
    )

    expect(summary.output).to eq(
      [
        "https://github.com/openfoodfoundation/openfoodnetwork/pull/3347\nA release note",
        "https://github.com/openfoodfoundation/openfoodnetwork/pull/3339\nA release note"
      ]
    )
  end
end
