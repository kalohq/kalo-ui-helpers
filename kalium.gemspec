lib = File.expand_path("../lib-gem", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kalium/version"

Gem::Specification.new do |spec|
  spec.name          = "kalium"
  spec.version       = Kalium:VERSION
  spec.authors       = ["Kalo Team"]
  spec.email         = ["tech@kalohq.com"]

  spec.summary       = "Shared Kalo Rails helpers"
  spec.description   = "A set of shared helpers, styles, and other assets for our Rails projects"
  spec.homepage      = "https://github.com/kalohq/kalium"

  spec.files         = `git ls-files`.split($\) - %w(.circleci config flow-typed lib scripts site src .babelrc .eslintignore .eslintrc.js .flowconfig .gitignore .istanbul.yml .nvmrc .prettierignore .prettierrc gulpfile.js package-lock.json package.json postcss.config.js wallaby.js)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end