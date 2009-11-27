require File.join(File.dirname(__FILE__), "lib", "acts_as_moonstone")

Acts::Moonstone::CONFIG = YAML.load_file(File.join(RAILS_ROOT, "config", "moonstone_config.yml"))
Acts::Moonstone::INDEX = Acts::Moonstone::CONFIG["path_to_index"] || File.join(RAILS_ROOT, "index")

class ActiveRecord::Base
  extend Acts::Moonstone
end