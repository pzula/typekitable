module Typekitable
  class Commander < Thor
    include Thor::Actions

    desc :test, "Is it working again?"
    def test
      say("Get everything running again after massive deletion :(")
    end
  end
end
