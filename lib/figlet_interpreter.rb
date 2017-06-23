class String
  def to_utf8
    str = self.force_encoding("UTF-8")
    return str if str.valid_encoding?
    str = str.force_encoding("BINARY")
    str.encode("UTF-8", invalid: :replace, undef: :replace)
  end
end

module Font
  WD = File.dirname(__FILE__)
  class Figlet
    def initialize font
      unless Dir.entries("#{WD}/../fonts").include? "#{font}.flf"
        puts "Font not found!"
        exit 1
      end
      @fontName = font
    end

    private def scan
      contents = File.open("#{WD}/../fonts/#{@fontName}.flf").read.to_utf8
      lines = contents.split "\n"
      unless lines[0].include? "flf2a"
        puts "Invalid FIGlet v2.0 font.\nThis font is not compatible with this interpreter!"
        exit 1
      end

      meta = lines[0].split " "
      hardblank = meta[0][5];
      height    = meta[1].to_i; @height = height # as well
      baseline  = meta[2].to_i
      max_len   = meta[3].to_i
      old_lay   = meta[4].to_i
      commented = meta[5].to_i
      # defaults, currently not used
      @print_way = 0
      full_lay  = 64
      tag_count = 229
      if meta.size > 6 # overide defaults
        @print_way = meta[6].to_i
        full_lay  = meta[7].to_i
        tag_count = meta[8].to_i
      end
      # we've got the information, now delete it form the `lines`
      (0..commented).each { lines.delete_at 0 } # This bugger,
                                                # since I delete the first line
                                                # the next line has now become
                                                # the first line, embarrassing how long that took.
      endmark = lines[0][lines[0].length - 1]
      (0..lines.size - 1).each do |i|
        lines[i].gsub!(hardblank, " ")
        lines[i].gsub!(endmark, "")
      end

      charachter_hash = { # I really can't think
        ' ' => Array.new, # of a 'DRY' way of doing this.
        '!' => Array.new,
        '"' => Array.new,
        '#' => Array.new,
        '$' => Array.new,
        '%' => Array.new,
        '&' => Array.new,
        '\''=> Array.new,
        '(' => Array.new,
        ')' => Array.new,
        '*' => Array.new,
        '+' => Array.new,
        ',' => Array.new,
        '-' => Array.new,
        '.' => Array.new,
        '/' => Array.new,
        '0' => Array.new,
        '1' => Array.new,
        '2' => Array.new,
        '3' => Array.new,
        '4' => Array.new,
        '5' => Array.new,
        '6' => Array.new,
        '7' => Array.new,
        '8' => Array.new,
        '9' => Array.new,
        ':' => Array.new,
        ';' => Array.new,
        '<' => Array.new,
        '=' => Array.new,
        '>' => Array.new,
        '?' => Array.new,
        '@' => Array.new,
        'A' => Array.new,
        'B' => Array.new,
        'C' => Array.new,
        'D' => Array.new,
        'E' => Array.new,
        'F' => Array.new,
        'G' => Array.new, # Forgot the G
        'H' => Array.new,
        'I' => Array.new,
        'J' => Array.new,
        'K' => Array.new,
        'L' => Array.new,
        'M' => Array.new,
        'N' => Array.new,
        'O' => Array.new,
        'P' => Array.new,
        'Q' => Array.new,
        'R' => Array.new,
        'S' => Array.new,
        'T' => Array.new,
        'U' => Array.new,
        'V' => Array.new,
        'W' => Array.new,
        'X' => Array.new,
        'Y' => Array.new,
        'Z' => Array.new,
        '[' => Array.new,
        '\\'=> Array.new,
        ']' => Array.new,
        '^' => Array.new,
        '_' => Array.new,
        '`' => Array.new,
        'a' => Array.new,
        'b' => Array.new,
        'c' => Array.new,
        'd' => Array.new,
        'e' => Array.new,
        'f' => Array.new,
        'g' => Array.new,
        'h' => Array.new,
        'i' => Array.new,
        'j' => Array.new,
        'k' => Array.new,
        'l' => Array.new,
        'm' => Array.new,
        'n' => Array.new, # Maybe I should just do this using bytes...
        'o' => Array.new,
        'p' => Array.new,
        'q' => Array.new,
        'r' => Array.new,
        's' => Array.new,
        't' => Array.new,
        'u' => Array.new,
        'v' => Array.new,
        'w' => Array.new,
        'x' => Array.new,
        'y' => Array.new,
        'z' => Array.new,
        '{' => Array.new,
        '|' => Array.new,
        '}' => Array.new,
        '~' => Array.new,
      }

      charachter_hash.each do |key, value|
        (0..height - 1).each do |line|
          charachter_hash[key] << lines[line]
        end
        lines.slice! 0..height - 1
      end

      return charachter_hash
    end

    def font_data
      {'lookup_table': scan, 'height': @height, 'direction': @print_way}
    end
  end
end
