module TimeShit
  class CLI
  
    attr_accessor :options
    
    def initialize( args = [] )
      @date = Time.now.strftime( "%Y-%m-%d" )
      @options = { :start => Time.now.floor( Config.round ).strftime( "%H:%M" ) } if args.empty?
      @options = { :end => Time.now.ceil( Config.round ).strftime( "%H:%M" ) } if args.include?( "-e" )
    end

    def run
      timesheet = Storage::CSV.new
      timesheet.create_timesheet
      timesheet.set( @date, @options )
      timesheet.save
    end

  end
end