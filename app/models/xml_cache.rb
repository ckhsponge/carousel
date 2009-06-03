class XmlCache
  def cache_path
    "#{RAILS_ROOT}/cache"
  end
  
  def file_path
    "#{self.cache_path}/#{self.file_name}"
  end
  
  def write_file
    xml = self.to_xml
    File.open(self.file_path, 'w') do |f| 
      f.write(xml)
    end
  end
  
  def read_file
    File.open(self.file_path, 'r').read
  end
  
  def self.write_all
    if rand(2) == 0
      Events.new.write_file
      Specials.new.write_file
    else
      Specials.new.write_file
      Events.new.write_file
    end
  end
end
