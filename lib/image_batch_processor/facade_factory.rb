require 'ostruct'
require 'to_slug'

module ImageBatchProcessor
  class FacadeFactory

    def self.create(params = {})
      facade = OpenStruct.new(title: params[:name])
      facade.images = extract_images_for(params[:type], params[:name], params[:images]) || []
      facade.navigation = build_navigation_for(params[:type], facade.images) || []
      facade
    end

    private

    def self.extract_images_for(type, facade_name, images)
      case type
      when :index
        images[0..9]
      when :camera_make
        images.select { |image| image.camera_make == facade_name }[0..9]
      when :camera_model
        images.select { |image| image.camera_model == facade_name }
      end
    end

    def self.build_navigation_for(type, images)
      link_titles = []
      case type
        when :index
        link_titles << images.map(&:camera_make).uniq.compact
      when :camera_make
        link_titles << ['index'].concat(images.map(&:camera_model).uniq.compact)
      when :camera_model
        link_titles << ['index'].concat(images.map(&:camera_make).uniq.compact)
      end
      link_titles.flatten.inject([]) { |memo, title| memo << title_to_link(title) }
    end

    def self.title_to_link(title)
      OpenStruct.new(text: title, href: "#{title.to_slug}.html")
    end

  end
end