Gem::Specification.new do |s|
  s.name        = 'ruby_figlet'
  s.version     = '0.3.4'
  s.required_ruby_version = '>= 1.9.2'
  s.executables << 'ruby-figlet'
  s.date        = '2017-07-02'
  s.summary     = "FIGlet in Ruby"
  s.description = "FIGlet font interpretation library for Ruby"
  s.authors     = ["Demonstrandum"]
  s.email       = 'knutsen@jetspace.co'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path= 'lib'
  s.homepage    = 'https://github.com/Demonstrandum/RubyFiglet'
  s.license     = 'GPL-3.0'
end
