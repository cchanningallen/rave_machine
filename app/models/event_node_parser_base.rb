# Abstract template class responsible for parsing event data from an
# HTML node containing event data.

class EventNodeParserBase
  include TemplateClassErrors

  register_template_methods :date, :time, :name, :artists, :location,
    :description, :event_link, :ticket_link, :price, :age_limit

  def initialize(event_node)
    @event_node = event_node
  end

  def parsed_data
    {
      date: date,
      time: time,
      name: name,
      artists: artists,
      location: location,
      description: description,
      event_link: event_link,
      ticket_link: ticket_link,
      price: price,
      age_limit: age_limit
    }
  end

  def get_price_for_common_seller_sites
    case
    when ticket_link =~ /www\.eventbrite\.com/
      Eventbrite::PageParser.new(url: ticket_link).price
    else
      yield
    end
  end
end
