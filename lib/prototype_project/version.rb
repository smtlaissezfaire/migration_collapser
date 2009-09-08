module PrototypeProject
  module Version
    class << self
      def string
        @string ||= File.read(File.dirname(__FILE__) + "/../../VERSION").chomp
      end
    
      def major
        version_parts[0]
      end
      
      def minor
        version_parts[1]
      end
      
      def tiny
        version_parts[2]
      end
      
    private
    
      def version_parts
        string.split(".").map { |part| part.to_i }
      end
    end
  end
end