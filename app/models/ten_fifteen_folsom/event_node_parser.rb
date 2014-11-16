module TenFifteenFolsom
  class EventNodeParser < EventNodeParserBase
    def date
      raw_date = @event_node.css('.date-display-single')[0].content
      Date.strptime(raw_date, "%m/%d/%Y")
    end

    def time
      time_price_and_age[0].strip
    end

    def name
      @event_node.css('h2 a')[0].content
    end

    def artists
      @event_node.css('p strong')[0].content
        .gsub(/\n/, " + ")
        .gsub(/w\//, "")
        .split(/\s\+\s|,\s|&\sMORE!|ft\s/)
        .map(&:strip)
        .reject(&:blank?)
    end

    def location
      "1015 Folsom"
    end

    def description
      ""
    end

    def event_link
      @event_node.css('.event_link a')[0]['href']
    end

    def ticket_link
      @event_node.css('.event_link a')[1]['href']
    end

    def price
      time_price_and_age[1].strip
    end

    def age_limit
      time_price_and_age[2].strip
    end

    def time_price_and_age
      @time_price_and_age ||= @event_node.css('p').children.last.content.split(" / ")
    end
  end
end
