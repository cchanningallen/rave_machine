class TemplateMethodError < StandardError; end

module TemplateClassErrors
  extend ActiveSupport::Concern

  module ClassMethods
    def register_template_methods(*method_names)
      method_names.each do |method_name|
        define_method(method_name.to_sym) do
          raise TemplateMethodError.new("method '##{__method__}' called from template class #{self.class}")
        end
      end
    end
  end
end
