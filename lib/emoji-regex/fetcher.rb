require 'open-uri'

module EmojiRegex
  class Fetcher
    SOURCE = 'http://www.unicode.org/Public/emoji/1.0/emoji-data.txt'.freeze

    def initialize
      @emoji_code = open(SOURCE, &:read).split("\n").map { |x| x.split(" ;\t")[0] }
      @emoji_file_path = File.join(Dir.tmpdir, 'sorted_emoji.txt')
    end

    def save
      @emoji_file.tap do
        lines = @emoji_code.map { |line| line if line[0] != '#' }.compact.join("\n")

        File.write(@emoji_file_path, lines)
      end
    end
    alias update save

    def saved_path
      save unless File.exist?(@emoji_file_path)

      @emoji_file_path
    end
  end
end
