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

    default_task :help
    
    class_option "no-color", :type => :boolean, :banner => "Disable colorization in output"
    class_option "verbose",  :type => :boolean, :banner => "Enable verbose output mode", :aliases => "-V"

    def help(cli = nil)
      case cli
      when "sass" then command = "compile"
      when nil    then command = "pelt"
      else  command = pelt-#{cli}
      end
      
      manpages = %w(
        pelt
        pelt-config
        pelt-convert
        pelt-install
        pelt-update
        )
      if manpages.include?(command)
        root = File.expand_path("../man", __FILE__)
        if have_groff? && root !~ %r{^file:/.+!/META-INF/jruby.home/.+}
          groff   = "groff -Wall -mtty-char -mandoc -Tascii"
          pager   = ENV['MANPAGER'] || ENV['PAGER'] || 'more'
          Kernel.exec "#{groff} #{root}/#{command} | #{pager}"
        else
          puts File.read("#{root}/#{command}.txt")
        end
      else
        super
      end
    end
  
    desc "install", "Generates jquery-ui css compatable files into style parse lib flavored rake apps"
    long_desc <<-D
      install generates a default set of scss, mustache, or less compatable styles in the destination rails/rake root dir.
    D
    method_option "framework", :type => :string, :banner => "Use the specified framework to create the style"
    def install
      opts = options.dup
      if File.exist?("peltemplate")
        if Pelt.ui.confirm "this project is already wearing a rather fetching pelt
          you may want to keep your sites skins would you prefer to recompile ?. (Y/n)"
        # Pelt.ui.error "peltemplate already exists at #{Dir.pwd}/peltemplate"
        #         exit 1
          update
        elsif Pelt.ui.deny "would you rather we make a clean break with the current pelt
          and start fresh? This will remove your current setup (Y/n)"
          @installer ||= if options[:bare]
            Pelt::Installers::BareInstaller.new(*installer_args)
          else
            app.installer(*installer_args)
          end
        else
          Pelt.ui.error "Peltemplate already exists at #{Dir.pwd}/Peltemplate"
          exit 1
        end
      end
    end
      
    desc "update", "Brings changes up to date and into the pelempate file & folder"
    long_desc <<-D
      update Brings changes up to date and into the pelempate file & folder
    D
    def update
      opts = options.dup
      
    end
    
    
    def self.source_root
      File.expand_path(File.join(File.dirname(__FILE__), 'peltemplate'))
    end

  private

    def have_groff?
      system("which groff 2>&1 >#{NULL}") rescue false
    end
  end
end