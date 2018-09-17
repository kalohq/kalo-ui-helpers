ENV["RAILS_ENV"] = "test"
ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), "../")

require File.expand_path("../dummy/config/environment.rb", __FILE__)

require "rspec/rails"
require "factory_bot_rails"


Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
