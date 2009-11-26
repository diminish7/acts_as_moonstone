module Acts
  module Moonstone
    
    #Options:
    # => :exclude - Array of attributes to exclude from indexing
    # => :include - Array of methods to include when indexing (in addition to the ActiveRecord attrs)
    # => :index_automatically - Defaults to true, so that all CRUD operations update the index automatically
    #                           If false, indexing must be done explicitly
    # => :run_as_service - Defaults to false, so that the engine runs in the same process as the Rails app. If true,
    #                     the engine runs as a REST service
    def acts_as_moonstone(options={})
      include InstanceMethods
      extend ClassMethods
    end
    
    module InstanceMethods
    end
    
    module ClassMethods
    end
    
  end
end