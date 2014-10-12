require 'spec_helper'

describe ImageBatchProcessor do

  describe '.process' do

    let(:input_file) { File.join(SPEC_DIR, 'fixtures', 'works.xml') }
    let(:output_directory) { File.join(GEM_ROOT_DIR, 'tmp') }
    subject {  ImageBatchProcessor.process(input_file, output_directory) }

    it 'creates a index html file' do
      subject
      expect(File.exists?(File.join(output_directory, 'index.html'))).to eq true
    end

    it 'creates a html for each camera make' do
      subject
      expect(File.exists?(File.join(output_directory, 'canon.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'nikon-corporation.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'fujifilm.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'leica.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'fuji-photo-film-co-ltd-.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'panasonic.html'))).to eq true
    end

    it 'creates a html file for each camera model' do
      subject
      expect(File.exists?(File.join(output_directory, 'canon-eos-20d.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'canon-eos-400d-digital.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'd-lux-3.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'dmc-fz30.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'finepix-s6500fd.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'slp1000se.html'))).to eq true
      expect(File.exists?(File.join(output_directory, 'nikon-d80.html'))).to eq true
    end

    context 'when the input file does not exist' do

      let(:input_file) { 'made/up/file'}
      it { expect{subject}.to raise_error ArgumentError, 'Input file does not exist' }
    end

    # after { FileUtils.rm_rf(output_directory) }
  end
end