require 'rails_helper'

RSpec.describe TenFifteenFolsom::EventNodeParser do
  let(:event_site_html) { File.open('spec/fixtures/event_sites/ten_fifteen_folsom.html') }
  let(:event) { Nokogiri::HTML(event_site_html).css('.event_content').first }

  describe "#parsed_data" do
    let(:expected_response) do
      {
        date: Date.new(2014, 11, 20),
        time: "9pm-2am",
        name: "MACHINEDRUM + GOVINDA",
        artists: ["A LIGHT IN THE ATTIC THURSDAYS", "MACHINEDRUM", "GOVINDA"],
        location: "1015 Folsom",
        description: "",
        event_link: "http://1015.com/events/1015/112014",
        ticket_link: "http://www.eventbrite.com/e/govinda-tickets-12729858349?aff=deck",
        price: "$15",
        age_limit: "21+"
      }
    end

    it "returns formatted data" do
      expect(described_class.new(event).parsed_data).to eq(expected_response)
    end
  end
end
