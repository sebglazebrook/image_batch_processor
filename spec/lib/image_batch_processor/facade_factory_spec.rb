require 'spec_helper'

describe ImageBatchProcessor::FacadeFactory do

  describe '.create' do

    subject { ImageBatchProcessor::FacadeFactory.create(params) }

    context 'when creating an index facade' do

      let(:params) { {type: :index, name: 'index', images: build_images} }

      it 'sets the correct title' do
        expect(subject.title).to eq 'index'
      end

      it 'includes the first 10 images given' do
        expect(subject.images.all?{|i| i.class == ImageBatchProcessor::Image}).to eq true
        expect(subject.images.size).to be 10
      end

      it 'sets a navigation for the index and all camera makes' do
        expect(subject.navigation[0]).to eq(OpenStruct.new(text: 'NIKON CORPORATION', href: 'nikon-corporation.html'))
        expect(subject.navigation[1]).to eq(OpenStruct.new(text: 'Canon', href: 'canon.html'))
        expect(subject.navigation[2]).to eq(OpenStruct.new(text: 'FUJIFILM', href: 'fujifilm.html'))
        expect(subject.navigation[3]).to eq(OpenStruct.new(text: 'LEICA', href: 'leica.html'))
        expect(subject.navigation[4]).to eq(OpenStruct.new(text: 'FUJI PHOTO FILM CO., LTD.', href: 'fuji-photo-film-co-ltd-.html'))
        expect(subject.navigation[5]).to eq(OpenStruct.new(text: 'Panasonic', href: 'panasonic.html'))
      end
    end

    context 'when creating a camera_make facade' do

      let(:params) { {type: :camera_make, name: 'Panasonic', images: build_images} }

      it 'sets the correct title' do
        expect(subject.title).to eq 'Panasonic'
      end

      it 'includes a maximum of 10 images for that camera make' do
        expect(subject.images.size).to eq 2
        expect(subject.images.all?{|i| i.camera_make == 'Panasonic'}).to eq true
      end

      it 'sets a navigation to the index and each camera models for that make' do
        expect(subject.navigation[0]).to eq(OpenStruct.new(text: 'index', href: 'index.html'))
        expect(subject.navigation[1]).to eq(OpenStruct.new(text: 'DMC-FZ30', href: 'dmc-fz30.html'))
      end
    end

    context 'when creating a camera_model facade' do

      let(:params) { {type: :camera_model, name: 'D-LUX 3', images: build_images} }

      it 'sets the correct title' do
        expect(subject.title).to eq 'D-LUX 3'
      end

      it 'includes all images for the camera model' do
        expect(subject.images.size).to eq 5
        expect(subject.images.all?{|i| i.class == ImageBatchProcessor::Image}).to eq true
      end

      it 'sets a navigation to the index and the camera make for that model' do
        expect(subject.navigation[0]).to eq(OpenStruct.new(text: 'index', href: 'index.html'))
        expect(subject.navigation[1]).to eq(OpenStruct.new(text: 'LEICA', href: 'leica.html'))
      end
    end
  end
end