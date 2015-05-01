require 'yaml'

module ZipCodes
  VERSION = '0.2.0'

  class << self
    def identify country, code
      db[country.upcase][code]
    end

    def db
      @db ||= begin
        this_file = File.expand_path(File.dirname(__FILE__))
        data_files_path = Dir[File.join(this_file, "data", "*.yml")]

        zip_codes_by_country = {}
        data_files_path.each do |path|
          name = File.basename path, ".yml"
          zip_codes_by_country[name.upcase] = YAML.load(File.open(path))
        end
        zip_codes_by_country
      end
    end

    def load
      db
    end
  end
end
