require 'spec_helper'
require 'ostruct'
require 'nokogiri'

describe ImageBatchProcessor::HtmlBuilder do

  describe '#build' do

    let(:navigation) do
      [
          OpenStruct.new(href: 'first.html', text: 'First'),
          OpenStruct.new(href: 'second.html', text: 'Second'),
          OpenStruct.new(href: 'third.html', text: 'Third')
      ]
    end
    let(:facade) { OpenStruct.new(title: 'My Title', navigation: navigation, images: build_images[0..9]) }
    subject { ImageBatchProcessor::HtmlBuilder.new.build(facade) }
    let(:parsed_html) { Nokogiri::HTML(subject) }

    it 'renders the title' do
      expect(parsed_html.css('title').text).to eq 'My Title'
      expect(parsed_html.css('h1').text).to eq 'My Title'
    end

    it 'renders navigation' do
      expect(parsed_html.css('nav a').map(&:text)).to eq %w(First Second Third)
      hrefs = parsed_html.css('nav a').map { |nav| nav.attributes['href'].value }
      expect(hrefs).to eq %w(first.html second.html third.html)
    end

    it 'renders images' do
      expect(parsed_html.css('.thumbnail').size).to eq 10
    end
  end
end