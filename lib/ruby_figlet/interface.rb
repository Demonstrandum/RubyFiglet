class String
  def each
    i = 0
    while i < self.length
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
      data = FigFont::Figlet.new(font).font_data
      @lookup = data[:lookup_table]
      @height = data[:height]
      @direction = data[:direction]
      @smushing = data[:old_layout]
      string = string.reverse if @direction == 1
      @string = string
      @font = font
    end

    def stringify
      breaks = @string.split "\n"
      breaks.each_with_index do |break_line, i|
        string = String.new
        @height.times do |row|
          break_line.each { |char| string << @lookup[char][row] }
          string << "\n"
        end
        if @direction == 1
          lines = string.split "\n"
          (0..(%x[tput cols].to_i - 1) - lines[0].length).each do # Holy Moly, from 0 to (terminal width minus 1) minus length of the ascii art word.
            lines.each_with_index { |line, j| lines[j].insert 0, " " }
          end
          string = lines.join "\n"
        end
        breaks[i] = string
      end
      string = breaks.join ""

      lines = string.split "\n"
      offset = 0
      (lines.size).times do |j|
        if lines[j - offset].strip.empty? # when a line is deleted, there must be an offset as the new array is now shorter (after a delete) so we must climb back up it, so that whe don't dlete wrong lines and try to access non-existent indices
          lines.delete_at(j - offset)  # Remove any empty lines
          offset += 1
        end
      end
      return lines.join "\n"
    end

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
        dir[i] = "" unless dir[i].include?('.flf') || dir[i].include?('/')
      end

      dir.sort_by! &:downcase
      list = dir.join "\n"
      ignore = ["..", ".", ".DS_Store", "._.DS_Store", ".DS_Store?", ".Spotlight-V100", ".Trashes", "ehthumbs.db", "Thumbs.db", "desktop.ini"]
      ignore.each { |file| list.gsub! "#{file}/", "" }

      list.gsub! ".flf", "" # don't show extensions
      list.squeeze! "\n"
    end
  end
end
