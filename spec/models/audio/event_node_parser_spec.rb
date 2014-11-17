require 'rails_helper'

RSpec.describe Audio::EventNodeParser do
  let(:event_site_html) { File.open('spec/fixtures/event_sites/audio.html') }
  let(:event_description_site_html) {}
  let(:audio_buy_tickets_site_html) { File.open('spec/fixtures/event_sites/audio_buy_tickets.html') }
  let(:eventbrite_buy_tickets_site_html) { File.open('spec/fixtures/event_sites/eventbrite_audio_buy_tickets.html') }
  let(:events) { Nokogiri::HTML(event_site_html).css("#cal-event-entry") }
  let(:eventbrite_event) { events[0] }
  let(:audio_event) { events[1] }

  describe "#parsed_data" do
    context "eventbrite event" do
      let(:parser) { described_class.new(eventbrite_event) }

      before do
        expect_any_instance_of(Eventbrite::PageParser).to receive(:open_site).and_return(eventbrite_buy_tickets_site_html)
      end

      it { expect(parser.price).to eq("$10-$15") }
    end

    context "audio event" do
      let(:parser) { described_class.new(audio_event) }

      before do
        expect(parser).to receive(:open_ticket_site).and_return(audio_buy_tickets_site_html)
      end

      it { expect(parser.price).to eq("$10") }
    end
  end

  # describe "#parsed_data" do
  #   let(:expected_response) do
  #     {
  #       date: Date.new(2014, 11, 20),
  #       time: "9pm-2am",
  #       name: "MACHINEDRUM + GOVINDA",
  #       artists: ["A LIGHT IN THE ATTIC THURSDAYS", "MACHINEDRUM", "GOVINDA"],
  #       location: "1015 Folsom",
  #       description: "",
  #       event_link: "http://1015.com/events/1015/112014",
  #       ticket_link: "http://www.eventbrite.com/e/govinda-tickets-12729858349?aff=deck",
  #       price: "$15",
  #       age_limit: "21+"
  #     }
  #   end

  #   it "returns formatted data" do
  #     expect(described_class.new(event).parsed_data).to eq(expected_response)
  #   end
  # end
end
