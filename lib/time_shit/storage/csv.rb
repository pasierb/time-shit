require 'csv'

module TimeShit
  module Storage
    class CSV < Base

      def self.create_container
        Dir.mkdir( Config.container ) unless File.exists?( Config.container )
      end

      def name
        "#{super}.csv"
      end

      def save
        create_timesheet
        File.open( file_name, 'w+') do |f|
          sheet.each{|e| f << e.to_csv } 
        end
      end

      def create_timesheet
        unless File.exists?( file_name )
          File.open( file_name, 'w' )
          sheet << header
          save
        end
      end

      def sheet
        @sheet ||= ::CSV.read( file_name )
      end

      def get( key )
        result = get_row( key )
        Struct.new( :start, :end ).new( result[1], result[2] ) if result
      end

      def set( key, opts = { :start => Time.now } )
        result = get_row( key )
        if result
          new_result = result.dup
          new_result[1] = opts[:start] if opts[:start]
          new_result[2] = opts[:end] if opts[:end]
          @sheet[ @sheet.index(result) ] = new_result
        else
          sheet << [key, opts[:start], opts[:end]]
        end
      end

      protected 

      def get_row( key )
        sheet.select{|entry| entry.first == key }.last
      end

      def file_name
        File.join( Config.container, name )
      end

    end
  end
end