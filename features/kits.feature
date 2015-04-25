@mocked_home_directory
Feature: As a user with a stored token, I can interact with the commands

  Background:
    Given I run `bundle exec ruby bin/typekitable` interactively
    And I type "y"
    And I type "4d6141e7c82cb30affebcc392abc2ce3ab0ea4c1"

  Scenario: I can get a list of all of my commands
     Then the output should contain "Commands"

  Scenario: I can get a list of my kits
    Given I run `bundle exec ruby bin/typekitable kit list` interactively
     Then the output should contain "Kits"
