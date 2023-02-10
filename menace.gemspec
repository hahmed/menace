require_relative "lib/menace/version"

Gem::Specification.new do |spec|
  spec.name        = "menace"
  spec.version     = Menace::VERSION
  spec.authors     = ["Haroon Ahmed"]
  spec.email       = ["haroon.ahmed25@gmail.com"]
  spec.homepage    = "https://github.com/hahmed/menace"
  spec.summary     = "Menace is an Active Storage blob authentication gem."
  spec.description = "Make it easier to authenticate Active Storage blobs."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4"
  spec.add_development_dependency "sqlite3", "~> 1.4"
  spec.add_development_dependency "mocha", "~> 2.0"
end
