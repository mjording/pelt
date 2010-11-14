$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'pelt'
require 'spec'
require 'spec/autorun'

# Require the correct version of popen for the current platform
if RbConfig::CONFIG['host_os'] =~ /mingw|mswin/
  begin
    require 'win32/open3'
  rescue LoadError
    abort "Run `gem install win32-open3` to be able to run specs"
  end
else
  require 'open3'
end

Spec::Runner.configure do |config|
  
end
