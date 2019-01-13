class NoteParser
  HEADER = '#### Release notes'.freeze

  def parse(body)
    /#{HEADER}\s+(.+)/.match(body)[1]
  end

  private

  attr_reader :body
end
