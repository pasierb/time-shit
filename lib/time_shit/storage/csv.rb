module TimeShit
  module Storage
    class CSV < Base

      def self.create_container
        Dir.mkdir( Config.container ) unless File.exists?( Config.container )
      end

      def name
        @time.strftime "%Y_%m_timeshit.csv"
      end

      def save
        create_timesheet
      end

      def create_timesheet
        File.new( file_name, 'w' ) unless File.exists?( file_name )
      end

      protected 

      def file_name
        File.join( Config.container, name )
      end

    end
  end
end