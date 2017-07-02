# RubyFiglet
FIGlet in Ruby, font interpretation and printing.

## Install
From rubygems.org
```shell
gem install ruby_figlet
```

## Usage
```ruby
require 'ruby_figlet'
using RubyFiglet # For String.new(...).art / .art! Moneky Patches

puts RubyFiglet::Figlet.available # see all fonts and more in other dirs

moo = "Moo!"
moo.art!
puts moo # Default font is 'standard' when no arguments given
# =>
#  __  __                   _
# |  \/  |   ___     ___   | |
# | |\/| |  / _ \   / _ \  | |
# | |  | | | (_) | | (_) | |_|
# |_|  |_|  \___/   \___/  (_)

# or just

puts "meow...".art
puts RubyFiglet::Figlet.new "meow..." # both work the same

# str.art(font)/str.art!(font) and RubyFiglet::Figlet.new(str, font) have a font parameter!

puts "one zero one one".art 'binary' # => 01101111 01101110 01100101  01111010 01100101 01110010 01101111  01101111 01101110 01100101  01101111 01101110 01100101
puts "every base is base *10*".art 'hex' # => 65 76 65 72 79  62 61 73 65  69 73  62 61 73 65  2A 31 30 2A

# German support:
puts "Heizölrückstoßabdämpfung".art # =>
#  _   _          _         _   _   _          _   _          _            _              ___           _           _   _   _                        __                         
# | | | |   ___  (_)  ____ (_)_(_) | |  _ __  (_) (_)   ___  | | __  ___  | |_    ___    / _ \   __ _  | |__     __| | (_)_(_)  _ __ ___    _ __    / _|  _   _   _ __     __ _
# | |_| |  / _ \ | | |_  /  / _ \  | | | '__| | | | |  / __| | |/ / / __| | __|  / _ \  | |/ /  / _` | | '_ \   / _` |  / _` | | '_ ` _ \  | '_ \  | |_  | | | | | '_ \   / _` |
# |  _  | |  __/ | |  / /  | (_) | | | | |    | |_| | | (__  |   <  \__ \ | |_  | (_) | | |\ \ | (_| | | |_) | | (_| | | (_| | | | | | | | | |_) | |  _| | |_| | | | | | | (_| |
# |_| |_|  \___| |_| /___|  \___/  |_| |_|     \__,_|  \___| |_|\_\ |___/  \__|  \___/  | ||_/  \__,_| |_.__/   \__,_|  \__,_| |_| |_| |_| | .__/  |_|    \__,_| |_| |_|  \__, |
#                                                                                      |_|                                                |_|                            |___/

puts RubyFiglet::Figlet.new("It's an abstract sort of font", 'weird')

bowl = "Soup?"
bowl.art! 'alphabet'
puts bowl # =>  SSS                 ???  
          #    S                   ?   ?
          #     SSS  ooo u  u ppp     ?  
          #        S o o u  u p  p   ?   
          #    SSSS  ooo  uuu ppp    ?   
          #                   p          
          #                   p          
```
