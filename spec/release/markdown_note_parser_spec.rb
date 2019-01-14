require './spec/spec_helper'
require './lib/release/markdown_note_parser'

RSpec.describe MarkdownNoteParser do
  let(:markdown_note_parser) { described_class.new }

  describe '#parse' do
    context 'when the note follows a markdown header after blank line' do
      it 'returns the note' do
        body = <<-TEXT
#### Release notes

A note
        TEXT

        expect(markdown_note_parser.parse(body)).to eq('A note')
      end
    end

    context 'when the note follows a markdown header' do
      it 'returns the note' do
        body = <<-TEXT
#### Release notes
A note
        TEXT

        expect(markdown_note_parser.parse(body)).to eq('A note')
      end
    end

    context 'when the note follows a 3rd-level markdown header' do
      it 'returns the note' do
        body = <<-TEXT
### Release notes

A note
        TEXT

        expect(markdown_note_parser.parse(body)).to eq(nil)
      end
    end

    context 'when the note is followed by a 4th-level markdown header' do
      it 'returns the note' do
        body = <<-TEXT
#### Release notes

A note

#### Documentation updates
        TEXT

        expect(markdown_note_parser.parse(body)).to eq('A note')
      end
    end
  end
end
