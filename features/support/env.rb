require 'cucumber'
require 'aruba/cucumber'

Before do
  @dirs = [File.expand_path(File.join(File.dirname(__FILE__), '../..'))]
end

Before '@mocked_home_directory' do
  set_env 'HOME', File.expand_path(File.join(current_dir, 'home'))
  FileUtils.mkdir_p ENV['HOME']
end

After '@mocked_home_directory' do
  FileUtils.rm_f ENV['HOME']
end
