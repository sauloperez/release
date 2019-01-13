require 'github_api'

class Release
  def initialize(organization = 'openfoodfoundation', repository = 'openfoodnetwork')
    @organization = organization
    @repository = repository
    @github = Github.new
  end

  def last_release_version
    response = github.repos.releases.latest(organization, repository)
    response.body.tag_name
  end

  private

  attr_reader :github, :organization, :repository
end
