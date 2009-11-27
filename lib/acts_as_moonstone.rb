module Acts
  module Moonstone    
    #Options:
    # => :exclude - Array of attributes to exclude from indexing
    # => :include - Array of methods to include when indexing (in addition to the ActiveRecord attrs)
    def acts_as_moonstone(options={})
      extend ClassMethods
      include InstanceMethods
      @excluded_attributes = options[:exclude] ? options[:exclude].collect(&:to_sym) : []
      @included_methods = options[:include] ? options[:include].collect(&:to_sym) : []
      if moonstone_config[:run_as_service]
        extend RestfulClassMethods
        include RestulfInstanceMethods
      else
        extend InProcessClassMethods
        include InProcessInstanceMethods
      end
    end
    
  end
end