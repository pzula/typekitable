@mock_home_directory
Feature: As a user, I can enter my API token credentials

  Scenario: Invoking the CLI to re-authenticate with a token results in success
    Given I run `bundle exec ruby bin/typekitable re-authenticate` interactively
      And I type "y"
      And I type "4d6141e7c82cb30affebcc392abc2ce3ab0ea4c1"
     Then the output should contain "Thank you, your Typekit API token has been stored"

  Scenario: Invoking the CLI to re-authenticate without a token gives me API token generation information
    Given I run `bundle exec ruby bin/typekitable re-authenticate` interactively
      And I type "n"
     Then the output should contain "Generate an API token"
