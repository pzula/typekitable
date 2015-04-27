@mock_home_directory
Feature: As a user with a stored token, I can interact with the commands

  Background:
    * I have a stored token

  Scenario: I can get a list of all of my commands
    Given I run `bundle exec ruby bin/typekitable help`
     Then the output should contain "Commands"

  Scenario: I can get a list of my kits
    Given I run `bundle exec ruby bin/typekitable kit_list`
     Then the output should contain "rmc4kry"

  Scenario: I can get information about a kit
    Given I run `bundle exec ruby bin/typekitable kit_info "rmc4kry"`
     Then the output should contain "droid kit"

  Scenario: I can publish a draft kit
    Given I run `bundle exec ruby bin/typekitable kit_publish "rmc4kry"`
     Then the output should contain "published"

