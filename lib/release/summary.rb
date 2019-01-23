module Release
  class Summary
    def initialize(github, organization, repository, pull_requests)
      @github = github
      @organization = organization
      @repository = repository
      @pull_requests = pull_requests
    end

    def output
      pull_requests.map do |pull_request|
        pull_request = PullRequest.new(github, organization, repository, pull_request)
        "#{pull_request.html_url}\n#{pull_request.release_note}"
      end
    end

    private

    attr_reader :pull_requests, :github, :organization, :repository
  end
end
