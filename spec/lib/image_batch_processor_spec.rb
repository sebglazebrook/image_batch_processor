require 'spec_helper'

describe ImageBatchProcessor do

  describe '.process' do

    let(:input_file) { File.join(ROOT_DIR, 'spec', 'fixtures', 'works.xml') }
    let(:output_directory) { File.join(ROOT_DIR, 'tmp') }
    subject { ImageBatchProcessor.process(input_file, output_directory) }

    context 'when the input file does not exist' do

      let(:input_file) { File.join(ROOT_DIR, 'non', 'existent', 'file.xml') }
      it { expect{subject}.to raise_error(ArgumentError, 'Input file does not exist') }
    end

    context 'when the output directory does not exist' do

      let(:output_directory) { File.join(ROOT_DIR, 'tmp', Random.rand.to_s) }
      before { FileUtils.rmdir(output_directory) }

      it 'creates the path for the output directory' do
        subject
        expect(File.exists?(output_directory)).to eq true
      end

      after { FileUtils.rmdir(output_directory) }
    end
  end
end