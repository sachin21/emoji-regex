require 'open-uri'

module EmojiRegex
  class Fetcher
    SOURCE = 'https://www.unicode.org/Public/emoji/6.0/emoji-data.txt'.freeze

    def initialize
      @emoji_file_path = File.join(Dir.tmpdir, 'sorted_emoji.txt')
    end

    def save
      emoji_file = open(SOURCE, &:read)
      emoji_code_lines = emoji_file.split("\n").map { |x| x.split(' ;')[0] }.compact.map(&:rstrip)

      emoji_codes = emoji_code_lines.each_with_object([]) do |line, result|
        case line
        when /^#/
          nil
        when /^(0023|002A|0030)/
          nil
        when /^.{4,5}\.\./
          start_code_hex, end_code_hex = line.split('..')
          base_10_code_range = (start_code_hex.to_i(16)..end_code_hex.to_i(16))
          hex_codes = base_10_code_range.to_a.map { |base_10_code| base_10_code.to_s(16).rjust(4, '0').upcase }
          hex_codes.each { |code| result << code }
        else
          result << line
        end
      end

      File.open(@emoji_file_path, 'w') do |f|
        f << emoji_codes.uniq.join("\n")
      end
    end

    alias update save

    def saved_path
      save unless File.exist?(@emoji_file_path)

      @emoji_file_path
    end
  end
end
