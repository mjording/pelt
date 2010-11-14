require 'fileutils'

module Pelt
  class Settings
    
    
    def initialize(path=nil)
      @root   = path || root
      @config = File.exist?(config_file) ? YAML.load_file(config_file) : {}
    end

    def [](key)
      key = key_for(key)
      @config[key] || ENV[key]
    end

    def []=(key, value)
      set_key(key, value, @config, config_file)
    end
    
    
    def delete(key)
      @config
    end

    def all
      env_keys = ENV.keys.select { |k| k =~ /PELT_.*/ }
      keys =  @config.keys | env_keys

      keys.map do |key|
        key.sub(/^PELT_/, '').gsub(/__/, ".").downcase
      end
    end

    def locations(key)
      locations = {}

      locations[:local]  = @config[key] if @config.key?(key)
      locations[:env]    = ENV[key] if ENV[key]
      locations
    end

    def pretty_values_for(exposed_key)
      key = key_for(exposed_key)

      locations = []
      if @config.key?(key)
        locations << "Set for your local app (#{config_file}): #{@config[key].inspect}"
      end

      if value = ENV[key]
        locations << "Set via #{key}: #{value.inspect}"
      end

      return ["You have not configured a value for `#{exposed_key}`"] if locations.empty?
      locations
    end

    def without=(array)
      unless array.empty?
        self[:without] = array.join(":")
      end
    end

    def without
      self[:without] ? self[:without].split(":").map { |w| w.to_sym } : []
    end

    
    def path
      path = ENV[key_for(:path)]
      return path && !@config.key?(key_for(:path)) ? path : File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    end
    
    private
       def key_for(key)
         key = key.to_s.sub(".", "__").upcase
         "PELT_#{key}"
       end

       def set_key(key, value, hash, file)
         key = key_for(key)

         unless hash[key] == value
           hash[key] = value
           hash.delete(key) if value.nil?
           FileUtils.mkdir_p(file.dirname)
           File.open(file, "w") { |f| f.puts hash.to_yaml }
         end
         value
       end

       def config_file
         Pathname.new("#{@root}/pelt.yml")
       end
  end
end