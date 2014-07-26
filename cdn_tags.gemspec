$:.push File.expand_path("../lib", __FILE__)

require "cdn_tags/version"

Gem::Specification.new do |s|
  s.name        = "cdn_tags"
  s.version     = CdnTags::VERSION
  s.authors     = ["Daniel Perez"]
  s.email       = ["tuvistavie@gmail.com"]
  s.homepage    = "https://github.com/claude-tech/cdn-tags-rails"
  s.summary     = "Helpers to serve assets via CDN in Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["specs/**/*"]

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "nokogiri", "~> 1.6"
  s.add_development_dependency "coveralls", "~> 0.7"

  s.add_dependency "rails", ">= 3.0"
end
