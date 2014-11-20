# Generate Twitter Bootstrap-compatible forms.
class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  [
    :text_field, :text_area
  ].each do |selector|
    class_eval <<-RUBY, __FILE__, __LINE__
      def #{selector}(method, options = {}, &block)
        form_group do
          bootstrap_label(method) + control_div(method: method) do
            field = super method, { class: 'form-control' }.merge(options)
            field + help_text(&block)
          end
        end
      end
    RUBY
  end

  def check_box(method, options = {}, &block)
    form_group do
      control_div(method: method, offset: true) do
        @template.content_tag(:div, class: 'checkbox') do
          field = super method, options
          label(method, field.html_safe + ' ' + method.to_s.humanize)
        end + help_text(&block)
      end
    end
  end

  def bootstrap_label(method, *args)
    options = args.extract_options!
    label method, *args, { class: 'col-sm-2 control-label' }.merge(options)
  end

  def submit
    form_group do
      control_div(offset: true) do
        submit = super(class: 'btn btn-primary')
        cancel = @template.link_to('Cancel', @template.polymorphic_path(object), class: 'btn btn-default')

        submit + ' ' + cancel
      end
    end
  end

  private

  def form_group
    @template.content_tag :div, class: 'form-group' do
      yield
    end
  end

  def control_div(options = {}, &block)
    method = options.delete(:method)

    classes = ['col-sm-10']
    classes << 'col-sm-offset-2' if options[:offset]
    classes << 'has-error' if method.present? && object.errors[method].present?

    @template.content_tag(:div, class: classes.join(' '), &block)
  end

  def help_text(&block)
    if block_given?
      @template.content_tag(:p, class: 'help-block') do
        @template.capture(&block)
      end
    else
      ''
    end
  end
end

ActionView::Helpers::FormHelper.module_eval do
  # Generate a form for a model, with the right markup to be styled by Twitter
  # Bootstrap.
  def bootstrap_form_for(record, options = {}, &block)
    html_options = options.delete(:html) || {}
    form_for record, {
      builder: BootstrapFormBuilder,
      html: {
        class: 'form-horizontal',
        role: 'form'
      }.merge(html_options)
    }.merge(options), &block
  end
end
