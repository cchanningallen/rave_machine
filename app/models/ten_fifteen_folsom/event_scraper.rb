module TenFifteenFolsom
  class EventScraper < EventScraperBase
    SITE_ROOT_URL = "http://1015.com/onezerothree"

    protected

    def site_root_url
      SITE_ROOT_URL
    end

    # CSS Selector for event nodes
    def get_events
      @doc.css(".event_content")
    end

    def parser
      TenFifteenFolsom::EventNodeParser
    end
  end
end
