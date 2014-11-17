require 'rails_helper'

RSpec.describe EventScraperBase do
  describe "template methods" do
    it_handles_registered_template_methods(
      methods: [:get_events, :parser, :event_list_url],
    )
  end

  describe ".get_data" do
    it_raises_template_error(
      calling_method: 'get_data',
      error_method: 'event_list_url',
      class_method: true
    )
  end

  describe "#go_to_site" do
    it_raises_template_error(
      calling_method: 'go_to_site',
      error_method: 'event_list_url'
    )
  end

  describe "#parsed_data" do
    it_raises_template_error(
      calling_method: 'parsed_data',
      error_method: 'event_list_url',
    )
  end
end
