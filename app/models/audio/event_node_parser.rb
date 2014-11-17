module Audio
  class EventNodeParser < EventNodeParserBase
    include PriceFormatting

    def date
      month, day = @event_node.css('.home-event-blocks-date a')[0].content.split(".")
      Date.new(Date.today.year, month.to_i, day.to_i)
    end

    def time
      [6,7].include?(date.wday) ? "9:30pm-2:00am" : search_description_for_time
    end

    def name
      @event_node.css('.home-event-blocks-title a')[0].content
    end

    def artists
      name.gsub(/.+\: /, "")
        .split(/,\s/)
        .map(&:strip)
    end

    def location
      "Audio"
    end

    def description
      @description ||= event_details_page.css('#event-content-body')[0].content.scrub
    end

    def event_link
      "#{EventScraper::SITE_ROOT_URL}#{event_details_node['href']}"
    end

    def ticket_link
      @ticket_link ||= @event_node.css('#cal-more-info a').last['href']
    end

    def price
      get_price_for_common_seller_sites do
        prices = buy_tickets_page.css('#shopping_cart_add_item tr.showtier .col2').map do |price_cell|
          price_cell.content.strip.gsub("$", "").to_i
        end

        format_price_range(prices)
      end
    end

    def age_limit
      "21+"
    end

    protected

    def event_details_page
      @event_details_page ||= Nokogiri::HTML(open(event_link))
    end

    def event_details_node
      @event_details_node ||= @event_node.css('#cal-more-info a')[0]
    end

    def search_description_for_time
      match = /(\d{1,2}(p|a)m-\d{1,2}(p|a)m)/.match(description)
      match ? match[1] : ""
    end

    def buy_tickets_page
      @buy_tickets_page ||= Nokogiri::HTML(open_ticket_site)
    end

    def open_ticket_site
      open(ticket_link)
    end
  end
end
