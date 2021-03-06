# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spark_toolkit/version'

Gem::Specification.new do |spec|
  spec.name          = "spark_toolkit"
  spec.version       = SparkToolkit::VERSION
  spec.authors       = ["Yuli Mo"]
  spec.email         = ["lizz@lizz.me"]

  spec.summary       = %q{Yet Another Jruby Spark toolkit.}
  spec.description   = %q{Yet Another Jruby Spark toolkit.}
  spec.homepage      = "https://github.com/myl2821/spark_toolkit"
  spec.license       = "MIT"
  spec.platform      = "java"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'hbase-jruby'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
