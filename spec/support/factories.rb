def build_images
  ImageBatchProcessor::ImageFactory.create_from_file(File.join(SPEC_DIR, 'fixtures', 'works.xml'))
end