module Eventbrite
  class PageParser
    include PriceFormatting

    def initialize(url:)
      @url = url
    end

    def price
      prices = doc.css(".price_td input").map do |price_input|
        price_input['value'].to_i
      end

      format_price_range(prices)
    end

    def doc
      @doc ||= Nokogiri::HTML(open_site)
    end

    def open_site
      open(@url)
    end
  end
end
