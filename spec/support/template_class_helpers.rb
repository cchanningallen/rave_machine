def it_handles_registered_template_methods(methods:, instance_args: nil)
  methods.each do |method|
    it_raises_template_error(calling_method: method, instance_args: instance_args)
  end
end

def it_raises_template_error(calling_method:, error_method: nil, class_method: false, instance_args: nil)
  it "#{calling_method} raises template error" do
    expect {
      class_or_instance(
        is_class_method: class_method, instance_args: instance_args
      ).send(calling_method.to_sym)
    }.to raise_error(
      TemplateMethodError,
      "method '##{error_method || calling_method}' called from template class #{described_class}"
    )
  end

  def class_or_instance(is_class_method:, instance_args:)
    is_class_method ? described_class : class_instance(instance_args)
  end

  def class_instance(args = nil)
    args ? described_class.new(args) : described_class.new
  end
end
