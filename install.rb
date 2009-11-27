root = File.join(File.dirname(__FILE__), "..", "..", "..")
config_file = File.join(root, "config", "moonstone_config.yml")
index = File.expand_path(File.join(root, "index"))

#Make the default index folder
Dir.mkdir(index) unless File.exists?(index)
#Make the default config file
config =<<CONFIG
runs_as_service: false
index_manually: false
path_to_index: #{index}
CONFIG

File.open(config_file, "w") { |f| f.write(config) } unless File.exists?(config_file)