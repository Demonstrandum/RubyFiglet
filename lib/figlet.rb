require_relative 'figlet_interpreter'

class String
  def each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end
  def art(font='big');  Figlet.new(self, font).stringify end
  def art!(font='big'); replace art(font) end
end

class Figlet
  def initialize string, font='big'
    @string = string
    @font = font
    data = Font::Figlet.new(font).font_data
    @lookup = data[:lookup_table]
    @height = data[:height]
  end

  def stringify
    string = String.new
    (0..@height - 1).each do |line|
      @string.each do |char|
        string << @lookup[char][line]
      end
      string << "\n"
    end
    return string
  end

  def show
    print stringify
  end

  def self.available folder="../fonts"
    dir = Dir.entries(folder)
    (0..dir.size - 1).each do |i|
      dir[i] += '/' unless dir[i].include? '.flf'
    end
    list = dir.join "\n"
    ignore = ["..", ".", ".DS_Store", "._.DS_Store", ".DS_Store?", ".Spotlight-V100", ".Trashes", "ehthumbs.db", "Thumbs.db", "desktop.ini"]
    ignore.each { |file| list.gsub! "#{file}/", "" }
    list.gsub! ".flf", "" # ignore extensions

    return list
  end
end