require 'ostruct'

module ImageBatchProcessor
  class Image < OpenStruct

    def camera_model
      self['exif']['model']
    end

    def camera_make
      self['exif']['make']
    end

    def thumbnail
      self['urls']['url'].first
    end

    def main_image
      self['urls']['url'].last
    end

  end
end