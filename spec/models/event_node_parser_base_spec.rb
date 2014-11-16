require 'rails_helper'

RSpec.describe EventNodeParserBase do
  describe "template methods" do
    it_handles_registered_template_methods(
      methods: [:date, :name, :artists, :location, :description,
        :event_link, :ticket_link],
      instance_args: {},
    )
  end

  describe "#parsed_data" do
    it_raises_template_error(
      calling_method: 'parsed_data',
      error_method: 'date',
      instance_args: {},
    )
  end
end
