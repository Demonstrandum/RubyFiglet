require_relative 'lib/ruby_figlet'

Gem::Specification.new do |s|
  s.name        = 'ruby_figlet'
  s.version     = RubyFiglet::version
  s.required_ruby_version = '>= 2.0.0'
  s.executables << 'ruby-figlet'
  s.date        = Time.now.to_s.split(/\s/)[0]
  s.summary     = "FIGlet in Ruby"
  s.description = "FIGlet font interpretation and printing library for Ruby"
  s.authors     = ["Demonstrandum"]
  s.email       = 'knutsen@jetspace.co'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path= 'lib'
  s.homepage    = 'https://github.com/Demonstrandum/RubyFiglet'
  s.license     = 'GPL-3.0'
end
