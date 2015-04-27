require 'cucumber'
require 'aruba/cucumber'
require 'aruba/in_process'
require 'vcr'
require 'webmock'
require 'typekitable/runner'

VCR.cucumber_tags do |t|
  t.tag  '@vcr', :use_scenario_name => true
end

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = 'features/cassettes'
  c.default_cassette_options = { :record => :new_episodes }
end

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

Before '@vcr'  do
  Aruba::InProcess.main_class = Typekitable::Runner
  Aruba.process = Aruba::InProcess
end

After '@vcr'  do
  Aruba.process = Aruba::SpawnProcess
  VCR.eject_cassette
  $stdin = STDIN
  $stdout = STDOUT
end
