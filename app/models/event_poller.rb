class EventPoller
  SCRAPERS = [
    TenFifteenFolsom::EventScraper,
    Audio::EventScraper,
  ]

  def self.poll_sources_and_create_events
    SCRAPERS.each do |scraper|
      scraper.get_data.each do |event_data|
        Event.create(event_data)
      end
    end
  end
end
