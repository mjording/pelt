require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "pelt"
    gem.summary = %Q{A SASS/SCSS jQuery UI Port for Theme Management and Extensibility}
    gem.description = %Q{A SASS/SCSS jQuery UI Port for Theme Management and Extensibility}
    gem.email = "rbradberry@gmail.com"
    gem.homepage = "http://github.com/nyc-ruby-meetup/pelt"
    gem.authors = ["russ bradberry", "matthew jording"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "ronn"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_dependency 'sass'
    gem.add_dependency 'thor'
    gem.files = Dir.glob('lib/**/*.rb')
    # Man files are required because they are ignored by git
    man_files            = Dir.glob("lib/bundler/man/**/*")
      
    gem.files              = `git ls-files`.split("\n") + man_files
    # gem.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
    gem.executables        = %w(pelt)
    gem.default_executable = "pelt"
    gem.require_paths      = ["lib"]
  end
  Jeweler::GemcutterTasks.new
  rescue LoadError
    puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
  end

  require 'spec/rake/spectask'
  Spec::Rake::SpecTask.new(:spec) do |spec|
    spec.libs << 'lib' << 'spec'
    spec.spec_files = FileList['spec/**/*_spec.rb']
  end

  Spec::Rake::SpecTask.new(:rcov) do |spec|
    spec.libs << 'lib' << 'spec'
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov = true
  end

  task :spec => :check_dependencies

  begin
    require 'reek/adapters/rake_task'
    Reek::RakeTask.new do |t|
      t.fail_on_error = true
      t.verbose = false
      t.source_files = 'lib/**/*.rb'
    end
  rescue LoadError
    task :reek do
      abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
    end
  end

  begin
    require 'roodi'
    require 'roodi_task'
    RoodiTask.new do |t|
      t.verbose = false
    end
  rescue LoadError
    task :roodi do
      abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
    end
  end

  task :default => :spec

  begin
    require 'yard'
    YARD::Rake::YardocTask.new
  rescue LoadError
    task :yardoc do
      abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
    end
end
