# ImageBatchProcessor

Gem to display thumbnail images from xml exif data

## Installation

Add this line to your application's Gemfile:

    gem 'image_batch_processor', :git => 'git://github.com/sebglazebrook/image_batch_processor.git'

And then execute:

    $ bundle

## Usage

    require 'image_batch_processor'
    
    ImageBatchProcessor.process('/my/exif/file.xml', '/my/output/dir')

## Contributing

1. Fork it ( https://github.com/[my-github-username]/image_batch_processor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
