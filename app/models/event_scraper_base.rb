require 'open-uri'

class EventScraperBase
  include TemplateClassErrors

  attr_accessor :doc

  register_template_methods :get_events, :parser, :event_list_url

  def self.get_data
    self.new.parsed_data
  end

  def parsed_data
    go_to_site

    get_events.each_with_object([]) do |event, event_data|
      event_data << parser.new(event).parsed_data
    end
  end

  # protected

  def go_to_site
    @doc = Nokogiri::HTML(open_site)
  end

  def open_site
    open(event_list_url)
  end
end

