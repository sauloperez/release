class LatestRelease
  def initialize(github, organization, repository)
    @github = github
    @organization = organization
    @repository = repository
  end

  def tag_name
    body.tag_name
  end

  def revision
    body.target_commitish
  end

  private

  attr_reader :github, :organization, :repository

  def response
    @response ||= github.repos.releases.latest(organization, repository)
  end

  def body
    response.body
  end
end
