# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'image_batch_processor/version'

Gem::Specification.new do |spec|
  spec.name          = "image_batch_processor"
  spec.version       = ImageBatchProcessor::VERSION
  spec.authors       = ["Seb Glazebrook"]
  spec.email         = ["me@sebglazebrook.com"]
  spec.summary       = %q{Batch Process Images}
  spec.description   = %q{Using EXIF data display image thumbnails categorised by camera make and model}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'to_slug'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'nokogiri'
end
