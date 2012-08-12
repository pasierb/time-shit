require 'date'
require 'time'

module TimeShit
  module Storage
    class Base
      
      def initialize( time = Time.now )
        @time = time
      end

      def save
        false
      end

      def name
        @time.strftime( "%Y_%m_timeshit" )
      end

      def sheet
      end

      def header
        %w(Date Start End)
      end

      def get( key )
      end

      def set( key, opts = { :start => Time.now } )
      end

    end
  end
end