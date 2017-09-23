Dir["#{File.dirname __FILE__}/ruby_figlet/*.rb"].each { |f| require f }

module RubyFiglet
  VERSIONS = { :major => 0, :minor => 5, :tiny => 1 }

  def self.version *args
    VERSIONS.flatten.select.with_index { |val, i| i.odd? }.join '.'
  end
end
