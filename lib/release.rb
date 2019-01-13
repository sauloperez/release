require 'github_api'

class Release
  def initialize(organization = 'openfoodfoundation', repository = 'openfoodnetwork')
    @organization = organization
    @repository = repository
    @github = Github.new
  end

  def call
    response = github.repos.releases.latest(organization, repository)
    response.body.name
  end

  private

  attr_reader :github, :organization, :repository
end
