require 'rbconfig'
require 'pathname'


module Pelt
    ORIGINAL_ENV = ENV.to_hash
    
    autoload :UI,         'pelt/ui'
    autoload :Settings,   'pelt/settings'
    autoload :Installers, 'pelt/installers'
    autoload :Frameworks, 'pelt/frameworks'
    
    WINDOWS = RbConfig::CONFIG["host_os"] =~ %r!(msdos|mswin|djgpp|mingw)!
    FREEBSD = RbConfig::CONFIG["host_os"] =~ /bsd/
    NULL    = WINDOWS ? "NUL" : "/dev/null"
    
    class << self
      attr_writer :ui, :base_directory
     
      
      def mkdir_p(path)
          FileUtils.mkdir_p(path)
      end
      
      def read_file(file)
        File.open(file, "rb") { |f| f.read }
      end
      
      def configure
        @configured ||= begin
          configure_pelted_home_and_path
          true
        end
      end

      def ui
        @ui ||= UI.new
      end

      def root
        default_pelt
      end
      
      
      def default_pelt
        base_directory
      end
      
      def base_directory
        File.expand_path(File.join(File.dirname(__FILE__), '..'))
      end

      def pelted_path
        # STDERR.puts settings.path
        @pelted_path ||= Pathname.new(settings.path)
      end
      
      def app_config_path
        ENV['PELT_APP_CONFIG'] ?
          Pathname.new(ENV['PELT_APP_CONFIG']).expand_path(root) : root
          # root.join('.pelt')
      end
      
      def settings
        @settings ||= Settings.new(app_config_path)
      end
      
      def frameworks
        @frameworks ||= Pelt::Frameworks
      end
      private

        def configure_pelted_home_and_path
          # paths = [Gem.dir, Gem.path].flatten.compact.uniq.reject{|p| p.empty? }
          FileUtils.mkdir_p pelted_path.to_s
        end
    end
end