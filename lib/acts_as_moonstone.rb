here = File.dirname(__FILE__)
require File.join(here, "in_process_methods")
require File.join(here, "restful_methods")
require File.join(here, "common_methods")

module Acts
  module Moonstone    
    #Options:
    # => :exclude - Array of attributes to exclude from indexing
    # => :include - Array of methods to include when indexing (in addition to the ActiveRecord attrs)
    def acts_as_moonstone(options={})
      include InstanceMethods
      extend ClassMethods
      if moonstone_config[:run_as_service]
        include RestulfInstanceMethods
        extend RestfulClassMethods
      else
        include InProcessInstanceMethods
        extend InProcessClassMethods
      end
    end
    
    def moonstone_config
      Acts::Moonstone::CONFIG
    end
    
  end
end