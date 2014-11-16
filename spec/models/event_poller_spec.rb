require 'rails_helper'

# This is an integration spec.
RSpec.describe EventPoller do
  let(:first_site_html) { File.open('spec/fixtures/event_sites/ten_fifteen_folsom.html') }
  let(:first_scraper) { TenFifteenFolsom::EventScraper }
  let(:first_event) { Event.first }

  before do
    stub_const("SCRAPERS", [first_scraper])
    allow_any_instance_of(first_scraper).to receive(:open_site).and_return(first_site_html)
    described_class.poll_sources_and_create_events
  end

  it "creates correct number of events" do
    expect(Event.count).to eq(2)
  end

  it "creates events with correct data" do
    expect(first_event.age_limit).to eq("21+")
    expect(first_event.artists).to eq(["A LIGHT IN THE ATTIC THURSDAYS", "MACHINEDRUM", "GOVINDA"])
    expect(first_event.date).to eq(Date.new(2014,11,20))
    expect(first_event.description).to eq("")
    expect(first_event.event_link).to eq("http://1015.com/events/1015/112014")
    expect(first_event.location).to eq("1015 Folsom")
    expect(first_event.name).to eq("MACHINEDRUM + GOVINDA")
    expect(first_event.price).to eq("$15")
    expect(first_event.ticket_link).to eq("http://www.eventbrite.com/e/govinda-tickets-12729858349?aff=deck")
    expect(first_event.time).to eq("9pm-2am")
  end

  it "doesn't duplicate existing events" do
    described_class.poll_sources_and_create_events
    expect(Event.count).to eq(2)
  end
end
