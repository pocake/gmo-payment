require 'yaml'

begin
  CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml'))
rescue Exception => e
  CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml.sample'))
end
