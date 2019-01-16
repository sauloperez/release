class PullRequests
  def initialize(github, organization, repository)
    @github = github
    @since = since
    @organization = organization
    @repository = repository
  end

  def get(since)
    params = "is:pr repo:#{organization}/#{repository} merged:>#{since}"
    response = github.search.issues(params)
    response.body.items
  end

  private

  attr_reader :github, :since, :organization, :repository
end
