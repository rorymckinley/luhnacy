Gem::Specification.new do |s|
  s.name = "luhnacy"
  s.version = File.read('VERSION')

  s.authors = ["Rory McKinley"]
  s.description = "luhnacy can be used to validate strings for Luhn compliance as well as generating valid or invalid strings for the purposes of testing "
  s.email = "rorymckinley@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/luhnacy.rb",
    "luhnacy.gemspec",
    "spec/luhnacy_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/rorymckinley/luhnacy"
  s.summary = "A gem tohelp with the tedium of validating Luhn-compliant strings"

  s.add_development_dependency "rspec", ">= 2", "< 3"
  s.add_development_dependency "rake", "~> 13.0.3"
  s.add_development_dependency "bundler-audit"
end
