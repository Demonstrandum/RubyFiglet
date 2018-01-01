class String
  def each
    i = 0
    while i < length
      yield self[i]
      i += 1
    end
  end
end

module RubyFiglet
  refine String do
    def art(font='standard');  RubyFiglet::Figlet.new(self, font).stringify end
    def art!(font='standard'); replace art(font) end
  end

  class Figlet
    def initialize string, font='standard'
      parsed = Parser.new(font)
      font_data = parsed.font_table
      @lookup = font_data[:letter_lookup]
      @height = font_data[:height]
      @direction = font_data[:direction]
      @smushing = font_data[:old_layout]
      string = string.reverse if @direction == 1
      @string = string
      @font = font
    end

    def to_s
      breaks = @string.split "\n"
      breaks.each_with_index do |break_line, i|
        string = String.new
        @height.times do |row|
          break_line.each { |char| string << @lookup[char][row] }
          string << "\n"
        end
        if @direction == 1
          lines = string.split "\n"
          (0..(%x[tput cols].to_i - 1) - lines.max_by(&:length).length).each do
            # Holy Moly, from 0 to (terminal width minus 1) minus max length
            # of the ASCII art word.
            lines.each_with_index { |_, j| lines[j].insert 0, " " }
          end
          string = lines.join "\n"
        end
        breaks[i] = string
      end
      string = breaks.join ""

      lines = string.split "\n"
      offset = 0
      (lines.size).times do |j|
        if lines[j - offset].strip.empty?
          lines.delete_at(j - offset)  # Remove any empty lines
          offset += 1
        end
      end
      lines.join "\n"
    end

    alias stringify to_s

    def show
      puts stringify
    end

    WD = File.dirname(__FILE__)
    def self.available folder="#{WD}/fonts/"
      dir = Dir.entries(folder)
      (0..dir.size - 1).each do |i|
        dir[i] += '/' unless dir[i].include? '.'
      end
      (0..dir.size - 1).each do |i|
        dir[i] = '' unless dir[i].include?('.flf') || dir[i].include?('/')
      end

      dir.sort_by!(&:downcase)
      list = dir.join "\n"
      ignore = ["..", ".", ".DS_Store", "._.DS_Store", ".DS_Store?", ".Spotlight-V100", ".Trashes", "ehthumbs.db", "Thumbs.db", "desktop.ini"]
      ignore.each { |file| list.gsub! "#{file}/", "" }

      list.gsub! ".flf", ""  # Don't show extensions
      list.squeeze! "\n"
    end
  end
end
