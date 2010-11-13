module Pelt
  module Installers

    class Base
      
      attr_accessor :template_path, :target_path, :working_path
      attr_accessor :options
      def initialize(template_path, target_path, options = {})
        @template_path = template_path
        @target_path = target_path
        @working_path = Dir.getwd
        @options = options
        self.logger = options[:logger]
      end
      [:css_dir, :sass_dir, :images_dir, :javascripts_dir, :http_stylesheets_path, :fonts_dir, :preferred_syntax].each do |s,dir|
        define_method dir do
          Pelt.settings[:s] = dir
          # Pelt.configuration.send(dir)
        end
        define_method "#{dir}_without_default" do
          Pelt.settings[:s] = dir
        end
      end
      
      
      
      installer :stylesheet do |to|
        "#{sass_dir}/#{pattern_name_as_dir}#{to}"
      end
      
      
      
    end
  end
end