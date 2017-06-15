class String
  def each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end
  def art;  ArtASCII.new(self).stringify end
  def art!; replace art end
end

class ArtASCII
  def initialize string
    @string = string
    @height = 6
    @width  = 10
  end

  private def chars char
    lookup = {
      'A' => [
        "           ",
        "    /\\    ",
        "   /  \\   ",
        "  / /\\ \\  ",
        " / ____ \\ ",
        "/_/    \\_\\"
      ],
      'B' => [
        "____   ",
        "|  _ \\ ",
        "| |_) |",
        "|  _ < ",
        "| |_) |",
        "|____/ "
      ]
    }
    return lookup[char]
  end

  def stringify
    string = String.new
    arr = []
    (0..@height - 1).each do |line|
      @string.each do |char|
        string << chars(char)[line]
      end
      string << "\n"
    end
    return string
  end

  def show
    print stringify
  end
end

#ascii = ArtASCII.new('ABBBBA')
#ascii.show

ascii = 'ABB'.art!
puts ascii
