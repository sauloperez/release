require 'pry'
require 'github_api'

require './lib/release/markdown_note_parser'

class Release
  def initialize(organization, repository, note_parser = MarkdownNoteParser.new)
    @organization = organization
    @repository = repository
    @note_parser = note_parser

    @github = Github.new do |config|
      config.oauth_token = ENV['GITHUB_ACCESS_TOKEN']
    end
  end

  def last_release_version
    response = github.repos.releases.latest(organization, repository)
    response.body.tag_name
  end

  def release_note(pr_number)
    body = note(pr_number)
    parse(body)
  end

  def pull_requests(since:)
    response = github.search.issues("is:pr repo:#{GITHUB_OFN_ORGANIZATION}/#{GITHUB_OFN_REPOSITORY} merged:>#{since}")
    response.body.items.map(&:number)
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
