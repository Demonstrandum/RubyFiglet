# RubyFiglet
FIGlet in Ruby, font interpretation and printing.

## Usage
```ruby
require 'figlet'

puts Figlet.available # see all fonts and more in other dirs

moo = "Moo!"
moo.art!
puts moo # Default font is 'big' hwen no arguments given
# =>
# __  __                   _
# |  \/  |                 | |
# | \  / |   ___     ___   | |
# | |\/| |  / _ \   / _ \  | |
# | |  | | | (_) | | (_) | |_|
# |_|  |_|  \___/   \___/  (_)

# or just

puts "meow...".art
puts Figlet.new "meow..." # both work the same

# str.art(font)/str.art!(font) and Figlet.new(str, font) have a font parameter!

puts "one zero one one".art('binary') # => 01101111 01101110 01100101  01111010 01100101 01110010 01101111  01101111 01101110 01100101  01101111 01101110 01100101
puts Figlet.new("It's an abstract sort of font", 'weird')
bowl = "Soup?"
bowl.art! 'alphabet'
puts bowl
```
