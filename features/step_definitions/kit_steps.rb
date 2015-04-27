Given(/^I have a stored token$/) do
  File.open(File.absolute_path('.typekitable', Dir.home), 'w') do |file|
    file.write("5e4ce50b7c5b996b2fb5e65ee4a6b870b9bd3297")
  end
end
