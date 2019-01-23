module Release
  class PullRequest
    def initialize(github, organization, repository, pull_request)
      @github = github
      @organization = organization
      @repository = repository
      @pull_request = pull_request
      @note_parser = MarkdownNoteParser.new
    end

    def html_url
      pull_request.html_url
    end

    def release_note
      parse(note)
    end

    def number
      pull_request.number
    end

    private

    attr_reader :pull_request, :github, :organization, :repository, :note_parser

    def note
      response = github.pull_requests.get(organization, repository, number)
      response.body.body
    end

    def parse(body)
      note_parser.parse(body)
    end
  end
end
