require 'figlet_interpreter'

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
      string = string.reverse if @direction == 1
      @string = string
      @font = font
    end

    def stringify
      string = String.new
      (0..@height - 1).each do |row|
        @string.each do |char|
          string << @lookup[char][row]
        end
        string << "\n"
      end
      lines = string.split "\n"
      if @direction == 1
        (0..(%x[tput cols].to_i - 1) - lines[0].length).each do # Holy Moly, from 0 to (terminal width minus 1) minus length of the ascii art word.
          lines.each_with_index do |line, i|
            lines[i].insert 0, " "
          end
        end
        return lines.join "\n"
      end
      return string
    end

    def show
      print stringify
    end

    WD = File.dirname(__FILE__)
    def self.available folder="#{WD}/fonts/"
      dir = Dir.entries(folder)
      (0..dir.size - 1).each do |i|
        dir[i] += '/' unless dir[i].include? '.flf'
      end
      list = dir.join "\n"
      ignore = ["..", ".", ".DS_Store", "._.DS_Store", ".DS_Store?", ".Spotlight-V100", ".Trashes", "ehthumbs.db", "Thumbs.db", "desktop.ini"]
      ignore.each { |file| list.gsub! "#{file}/", "" }
      list.gsub! ".flf", "" # don't show extensions

      return list.squeeze "\n"
    end
  end
end
