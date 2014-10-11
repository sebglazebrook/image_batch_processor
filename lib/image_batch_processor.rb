require "image_batch_processor/version"

module ImageBatchProcessor

  def self.process(input_file, output_directory)
    raise ArgumentError.new('Input file does not exist') unless File.exists?(input_file)
    FileUtils.mkdir_p(output_directory)
  end

end
