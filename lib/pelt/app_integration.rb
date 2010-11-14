
module Pelt
  module AppIntegration
    module Helpers
      def lookup(project_type)
        eval "Pelt::AppIntegration::#{camelize(project_type)}"
      rescue NameError
        raise Compass::Error, "No application integration exists for #{project_type}"
      end

      protected

      # Stolen from ActiveSupport
      def camelize(s)
        s.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      end

    end
    extend Helpers
  end
end
