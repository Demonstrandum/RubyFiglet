Dir["#{File.dirname __FILE__}/ruby_figlet/*.rb"].each { |f| require f }

# Main namespace for all RubyFIGlet classes and methods.
module RubyFiglet
  VERSIONS = { :major => 0, :minor => 6, :tiny => 1 }.freeze

  def self.version *args
    VERSIONS.flatten.select.with_index { |_, i| i.odd? }.join '.'
  end
end
