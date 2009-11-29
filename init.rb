require 'moonstone'
lib = File.join(File.dirname(__FILE__), "lib")
require File.join(lib, "engine")
require File.join(lib, "acts_as_moonstone")
require File.join(lib, "in_process_methods")
require File.join(lib, "restful_methods")
require File.join(lib, "common_methods")

Acts::Moonstone::CONFIG = YAML.load_file(File.join(RAILS_ROOT, "config", "moonstone_config.yml"))
Acts::Moonstone::INDEX = Acts::Moonstone::CONFIG["path_to_index"] || File.join(RAILS_ROOT, "index")
engine_class = Acts::Moonstone::CONFIG["engine"] ? Acts::Moonstone::CONFIG["engine"].constantize : Acts::Moonstone::Engine
Acts::Moonstone::ENGINE = engine_class.new(:store => Acts::Moonstone::INDEX)

class ActiveRecord::Base
  extend Acts::Moonstone
end