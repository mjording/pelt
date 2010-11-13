
module Pelt
  module AppIntegration
    module Rails
       def env
          if rails_env = (defined?(::Rails) ? ::Rails.env : (defined?(RAILS_ENV) ? RAILS_ENV : nil))
            rails_env.production? ? :production : :development
          end
        end
        def root
          if defined?(::Rails)
            ::Rails.root
          elsif defined?(RAILS_ROOT)
            RAILS_ROOT
          end
        end
    end
  end
end