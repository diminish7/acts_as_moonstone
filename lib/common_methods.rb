module Acts
  module Moonstone
    
    module InstanceMethods
      
      def indexables
        unless @indexables
          @indexables = self.attributes.keys.collect(&:to_sym)
          @indexables -= self.excluded_attributes
          @indexables += self.included_methods
        end
        @indexables
      end
      
      def excluded_attributes
        self.class.excluded_attributes
      end

      def included_methods
        self.class.included_methods
      end
    end
    
    module ClassMethods
      
      def moonstone_config
        Acts::Moonstone::CONFIG
      end

      def excluded_attributes
        @excluded_attributes
      end

      def included_methods
        @included_methods
      end
    end
    
  end
end