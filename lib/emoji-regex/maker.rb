module EmojiRegex
  class Maker
    def initialize
      @input_file_path = File.join(__dir__, '../../data', 'sorted_emoji.txt')
    end

    def regex
      regex = ranges.map do |e|
        l = e[0]
        r = e[1]
        next if l == '' || r == '' || !l[/\s/].nil? || !r[/\s/].nil?
        if l == r
          "\\u{#{l}}"
        else
          "\\u{#{l}}-\\u{#{r}}"
        end
      end
      regex.unshift '['
      regex.push ']'

      Regexp.new(regex.join)
    end

    def ranges
      prev = -1
      prev_hex = ''
      left = ''

      ranges = File.open(@input_file_path).map do |line|
        hex = line.to_i(16)
        if hex == prev || hex == prev + 1
          prev = hex
          prev_hex = line.chomp
          next
        end
        range = [left, prev_hex]
        left = line.chomp
        prev = hex
        prev_hex = left
        range
      end

      ranges
        .compact
        .reject { |a, b| a.empty? || b.empty? }
    end
  end
end
