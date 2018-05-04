lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "libkkc_ruby/version"

Gem::Specification.new do |spec|
  spec.name          = "libkkc_ruby"
  spec.version       = LibkkcRuby::VERSION
  spec.authors       = ["yamasy1549"]
  spec.email         = ["sanae@yamasy.info"]

  spec.summary       = "a Ruby wrapper of libkkc"
  spec.description   = "a Ruby wrapper of libkkc"
  spec.homepage      = "https://github.com/yamasy1549/libkkc_ruby"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
end
