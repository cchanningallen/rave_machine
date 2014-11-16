require 'rails_helper'

RSpec.describe TenFifteenFolsom::EventScraper do
  let(:event_site_html) { File.open('spec/fixtures/event_sites/ten_fifteen_folsom.html') }
  let(:event_scraper) { described_class.new }
  let(:parsed_data) { event_scraper.parsed_data }

  before do
    expect(event_scraper).to receive(:open_site).and_return(event_site_html)
  end

  describe "#parsed_data" do
    it "scrapes all events" do
      expect(parsed_data.length).to eq(2)
    end
  end
end
