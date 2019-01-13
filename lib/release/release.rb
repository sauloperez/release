require 'pry'
require 'github_api'

class Release
  def initialize(organization, repository)
    @organization = organization
    @repository = repository

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

  private

  attr_reader :github, :organization, :repository

  def note(pr_number)
    response = github.pull_requests.get(organization, repository, pr_number)
    response.body.body
  end

  def parse(body)
    /#### Release notes\s+(.+)/.match(body)[1]
  end
end
