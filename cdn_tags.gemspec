$:.push File.expand_path("../lib", __FILE__)

require "cdn_tags/version"

Gem::Specification.new do |s|
  s.name        = "cdn_tags"
  s.version     = CdnTags::VERSION
  s.authors     = ["Daniel Perez"]
  s.email       = ["tuvistavie@gmail.com"]
  s.homepage    = "https://github.com/claude-tech/rails-cdn-tags"
  s.summary     = "Helpers to use CDN scripts in Rails production."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "nokogiri", "~> 1.6"
  s.add_development_dependency "jazz_hands", "~> 0.5"

  s.add_dependency "rails", "~> 4.1"
end
