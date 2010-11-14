require 'thor'
require 'thor/actions'

module Pelt
  class CLI < Thor
    include Thor::Actions
    
    def initialize(*)
      super
      the_shell = (options["no-color"] ? Thor::Shell::Basic.new : shell)
      Pelt.ui = UI::Shell.new(the_shell)
      Pelt.ui.debug! if options["verbose"]
    end		
    
    check_unknown_options! unless ARGV.include?("exec") || ARGV.include?("config")
    
    default_task :install
    class_option "no-color", :type => :boolean, :banner => "Disable colorization in output"
    class_option "verbose",  :type => :boolean, :banner => "Enable verbose output mode", :aliases => "-V"
        
    desc "install", "Generates jquery-ui css compatable files into style parse lib flavored rake apps"
    long_desc <<-D
      install generates a default set of scss, mustache, or less compatable styles in the 
      destination rails/rake root dir.
    D
    
    method_option "framework", :type => :string, :banner =>
      "a framework, defaults to jquery-ui."
    method_option "markup", :type => :string, :banner =>
        "markup for templates. defaults to scss"
    def install
      
      opts = options.dup
      opts[:markup] ||= 'sass'
      opts[:framework] ||= 'jquery-ui'
      
      Pelt.ui.info "in the install at least"
      Pelt.ui.info "we have setting #{Pelt.settings.class}"
      # framework = Pelt.
      if opts.empty?
         Pelt.ui.info "keep it then"
       else
         Pelt.ui.info "#{Pelt.frameworks.class} already exists at #{Dir.pwd}"

        
    
      end
    end
    def self.source_root
      File.expand_path(File.join(File.dirname(__FILE__), '..'))
    end

  end
end