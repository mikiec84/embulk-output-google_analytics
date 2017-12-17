
Gem::Specification.new do |spec|
  spec.name          = "embulk-output-google_analytics"
  spec.version       = "0.1.0"
  spec.authors       = ["ryota.yamada"]
  spec.summary       = "Google Analytics output plugin for Embulk"
  spec.description   = "This plugin performs the data import and measurement protocol into Google Analytics."
  spec.email         = ["1987yama3@gmail.com"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/sem-technology/embulk-output-google_analytics"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "signet"
  spec.add_dependency "google-api-client", "~> 0.9.11"
  spec.add_development_dependency 'embulk', ['>= 0.8.38']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
