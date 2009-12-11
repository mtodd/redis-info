require 'yaml'

class Redis < Scout::Plugin
  KILOBYTE = 1024
  MEGABYTE = 1048576
  
  def build_report
    info = YAML.load(%x{redis-cli info}.gsub(/:/, ": "))
    
    report('used_memory_in_kb' => info['used_memory'] / KILOBYTE)
    report('used_memory_in_mb' => info['used_memory'] / MEGABYTE)
    
    # General Stats
    %w(used_memory changes_since_last_save).each do |key|
      report(key => info[key])
    end
  end
end
