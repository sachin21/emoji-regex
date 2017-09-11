module EmojiRegex
  class Maker
    def initialize
      @input_file_path = Fetcher.new.saved_path
      @prev = -1
      @prev_hex = ''
      @left = ''
      @ranges = []
    end

    def ranges
      ranges =
        File.open(@input_file_path).map do |line|
          hex = line.to_i(16)

          if [@prev, @prev + 1].include?(hex)
            @prev, @prev_hex = [hex, line.chomp] && next
          else
            [@left, @prev_hex].tap do
              @left = line.chomp
              @prev = hex
              @prev_hex = @left
            end
          end
        end

      ranges
        .compact
        .reject { |ary| ary[0].empty? || ary[1].empty? }
    end

    def regex
      regex = '[' +
              ranges.map do |range|
                left = range[0]
                right = range[1]
                next if left == '' || right == '' || !left[/\s/].nil? || !right[/\s/].nil?

                if left == right
                  "\\u{#{left}}"
                else
                  "\\u{#{left}}-\\u{#{right}}"
                end
              end.join + ']'
      Regexp.new(regex)
    end
  end
end
