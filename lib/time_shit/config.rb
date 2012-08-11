module TimeShit
  class Config

    def default
      { :container => lambda{ File.join( Dir.home, "time-shit" ) }.call }
    end

    def self.method_missing( method_name, *args )
      config = self.new
      config.default[method_name]
    end

  end
end