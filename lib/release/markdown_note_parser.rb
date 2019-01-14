class MarkdownNoteParser
  HEADER = '#### Release notes'.freeze

  def parse(body)
    match = /#{HEADER}\s+(.+)/.match(body)
    match[1] if match
  end

  private

  attr_reader :body
end
