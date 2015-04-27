# Typekitable

A CLI for interacting with your Typekit kits.

Get an API token [here](https://typekit.com/account/tokens) and get started!


## Installation

Install it yourself as:

    $ gem install typekitable

## Usage

  Command                         |  Description
  ------------------------------- |-------------------------------------
  typekitable kit_add NAME DOMAINS|  # Adds a new kit
  typekitable kit_info KIT_ID     |  # Get information on a specific kit
  typekitable kit_list            |  # Get a list of all of your kits
  typekitable kit_publish KIT_ID  |  # Publish a draft kit
  typekitable re-authenticate     |  # Reset your Typekit API token

## Tests

Unit tests are written with [rspec](https://github.com/rspec/rspec) and can be run with the command `rake spec`

Feature tests are written with [cucumber](https://github.com/cucumber/cucumber) and [aruba](https://github.com/cucumber/aruba) and can be run with the command `rake features`


## Contributing

1. Fork it ( https://github.com/pzula/typekitable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Add spec coverage
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
