Gem::Specification.new do |spec|
  spec.name          = "elegant_money"
  spec.version       = "0.1.0"
  spec.authors       = ["Nico"]
  spec.email         = ["ncls.ayala@gmail.com"]

  spec.summary       = %q{Elegant and simple implementation to handle money in different currencies}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/nicoayala/elegant_money"
  spec.license       = "MIT"

  spec.files         = `git ls-files lib spec *.md`.split("\n")
  spec.files        += %w[LICENSE.txt elegant_money.gemspec]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.1.2"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11"
end
