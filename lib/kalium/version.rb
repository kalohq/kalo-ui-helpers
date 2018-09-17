require "json"

module Kalium
  VERSION =
    JSON.load(
      File.open(
        File.expand_path("../../../version.json", __FILE__)
      )
    )["version"]
end
