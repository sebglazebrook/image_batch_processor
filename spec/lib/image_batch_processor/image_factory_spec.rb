require 'spec_helper'

describe ImageBatchProcessor::ImageFactory do

  describe '.create_from_file' do

    let(:file) { File.join(SPEC_DIR, 'fixtures', 'works.xml') }
    subject { ImageBatchProcessor::ImageFactory.create_from_file(file) }

    it 'creates an image for each piece of work' do
      expect(subject.all? {|i| i.class == ImageBatchProcessor::Image}).to eq true
      expect(subject.size).to eq 14
    end
  end
end