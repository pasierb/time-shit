module TimeShit
  module Storage
    class Base
      
      def initialize( time = Time.now )
        @time = time
      end

      def save
        false
      end

    end
  end
end