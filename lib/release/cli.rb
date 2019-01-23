require 'pry'
require 'github_api'

require './lib/release/markdown_note_parser'

module Release
  class CLI
    def initialize(organization, repository, note_parser = MarkdownNoteParser.new)
      @organization = organization
      @repository = repository
      @note_parser = note_parser

      @github = Github.new do |config|
        config.oauth_token = ENV['GITHUB_ACCESS_TOKEN']
      end
    end

    def last_release_version
      latest_release = LatestRelease.new(github, organization, repository)
      latest_release.tag_name
    end

    def release_note(pr_number)
      body = note(pr_number)
      parse(body)
    end

    def pull_requests(since:)
      pull_requests = PullRequests.new(github, organization, repository)
      pull_requests = pull_requests.get(since)

      Summary.new(github, organization, repository, pull_requests).output
    end

    private

    attr_reader :github, :organization, :repository, :note_parser

    def note(pr_number)
      response = github.pull_requests.get(organization, repository, pr_number)
      response.body.body
    end

    def parse(body)
      note_parser.parse(body)
    end
  end
end
