require 'pelt/installers'

module Pelt
  module Commands
    module InstallerCommand
      include Pelt::Installers
      
      
      def configure!
        Pelt.add_configuration(installer.completed_configuration, 'installer')
      end
      
      
      def app
        @app ||= Pelt::AppIntegration.lookup(Pelt.settings[:project_type])
      end
      
      def installer
        @installer ||= if options[:bare]
          Pelt::Installers::Base.new(*installer_args)
        else
          app.installer(*installer_args)
        end
      end

      def installer_args
        [template_directory(options[:pattern] || "project"), project_directory, options]
      end
    end
  end
end