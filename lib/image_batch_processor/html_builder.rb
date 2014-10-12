require 'ostruct'

module ImageBatchProcessor
  class HtmlBuilder

    def build(facade)
      ERB.new(template_file).result(facade.instance_eval { binding })
    end

    private

    def template_file
      Pathname.new(File.join(template_dir, 'images.html.erb')).read
    end

    def template_dir
      Pathname.new(File.expand_path(File.join('..', '..', '..', 'templates'), __FILE__))
    end
  end
end
