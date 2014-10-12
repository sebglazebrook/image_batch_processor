require 'image_batch_processor/version'
require 'image_batch_processor/image'
require 'image_batch_processor/image_factory'
require 'image_batch_processor/facade_factory'
require 'image_batch_processor/html_builder'
require 'to_slug'

module ImageBatchProcessor

  def self.process(input_file, output_directory)
    raise ArgumentError.new('Input file does not exist') unless File.exists?(input_file)
    Processor.new(input_file, output_directory).process
  end

  class Processor
    attr_reader :output_files, :output_directory, :input_file, :images, :facades

    def initialize(input_file, output_directory)
      @output_files = {}
      @input_file = input_file
      @output_directory = output_directory
      @facades = {}
    end

    def process
      create_images
      build_html_facades
      generate_html
      render_output
    end

    private

    def create_images
      @images = ImageFactory.create_from_file(input_file)
    end

    def build_html_facades
      facades['index.html'] = FacadeFactory.create(type: :index, name: 'index', images: images)
      images.map(&:camera_make).uniq.compact.each do |camera_make|
        facades["#{camera_make.to_slug}.html"] = FacadeFactory.create(type: :camera_make, name: camera_make, images: images)
      end
      images.map(&:camera_model).uniq.compact.each do |camera_model|
        facades["#{camera_model.to_slug}.html"] = FacadeFactory.create(type: :camera_model, name: camera_model, images: images)
      end
    end

    def generate_html
      facades.each { |key, facade| output_files[key] = HtmlBuilder.new.build(facade) }
    end

    def render_output
      FileUtils.mkdir_p(output_directory)
      output_files.each do |name, content|
        File.open(File.join(output_directory, name), 'w') { |f| f.write(content) }
      end
    end
  end
end
