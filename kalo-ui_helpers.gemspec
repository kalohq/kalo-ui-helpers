$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "kalo/ui_helpers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "kalo-ui_helpers"
  s.version = Kalo::UIHelpers::VERSION
  s.authors = ["Kalo Team"]
  s.email = ["tech@kalohq.com"]
  s.homepage = "https://github.com/kalohq/kalo-ui-helpers"
  s.summary = "Shared Kalo Rails helpers"
  s.description = "A set of shared helpers, styles, and other assets for our Rails projects"
  s.licenses = ["Nonstandard"]
  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]


  s.add_dependency "rails", "~> 5.2.1"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "faker"

  s.add_development_dependency "sqlite3"

  s.test_files = Dir["spec/**/*"]
end
