require 'cucumber'
require 'aruba/cucumber'

Before do
  @dirs = [File.expand_path(File.join(File.dirname(__FILE__), '../..'))]
end
