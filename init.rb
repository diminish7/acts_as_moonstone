require File.join(File.dirname(__FILE__), "lib", "acts_as_moonstone")

class ActiveRecord::Base
  extend Acts::Moonstone
end