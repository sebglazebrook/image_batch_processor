require 'active_support/core_ext/hash/conversions'

module ImageBatchProcessor
  class ImageFactory

    def self.create_from_file(file)
      extract_works(file).inject([]) do |memo, work|
        memo << ImageBatchProcessor::Image.new(work)
      end
    end

    private

    def self.extract_works(file)
      xml_hash = Hash.from_xml(File.open(file).read)
      xml_hash.first[1]['work']
    end

  end
end