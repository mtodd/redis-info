require 'yaml'

class Redis < Scout::Plugin
  def build_report
    info = YAML.load(%x{redis-cli info}.gsub(/:/, ": "))
    
    %w(used_memory changes_since_last_save).each do |key|
      report(key => info[key])
    end
  end
end
