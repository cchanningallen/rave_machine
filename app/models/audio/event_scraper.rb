module Audio
  class EventScraper < EventScraperBase
    SITE_ROOT_URL = "http://audiosf.com"

    # protected

    def event_list_url
      "#{SITE_ROOT_URL}/events"
    end

    # CSS Selector for event nodes
    def get_events
      @doc.css("#cal-event-entry")
    end

    def parser
      Audio::EventNodeParser
    end
  end
end
