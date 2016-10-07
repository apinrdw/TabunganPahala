module FormHelper
  class FormDecorator
    include ActionView::Context
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormTagHelper
    include SemanticIconHelper

    def initialize(model_data, f)
      @f = f

      if model_data.is_a? Symbol
        @model_name = model_data
      else
        @model_name = model_data.class.model_name.singular
      end
    end

    def check_box(name, text, args = {})
      checked_value = args.delete(:checked_value) || '1'
      args = { class: 'hidden', tabindex: '0' }.merge(args)

      field_wrapper = FieldWrapper.new(@f.object, name, true, args)
      field_wrapper.call('ui checkbox') do
        ui = []
        ui << check_box_tag("#{@f.object.model_name.singular}[#{name}]", checked_value, @f.object.active?, args)
        ui << (block_given? ? @f.label(name) { yield } : @f.label(name, text))
        ui.join.html_safe
      end
    end

    def submit_button(text, name = '', args = {})
      args = args.merge(class: 'ui button right labeled icon fluid primary', data: { disable_with: I18n.t('semantic_form.button.disable_with') })
      args = args.merge(name: name, value: true) if name.present?
      button_tag args do
        ui = []
        ui << semantic_icon('right arrow') if args[:icon]
        ui << text
        ui.join.html_safe
      end
    end

    # def email_field(name, args = {})
    #   args = default_args(name).merge(args)
    #
    #   field_wrapper(name, default_field_class) do
    #     ui = []
    #     ui << @f.email_field(name, args)
    #     ui << semantic_icon('mail')
    #     ui.join.html_safe
    #   end
    # end
    #
    # def password_field(name, args = {})
    #   args = default_args(name).merge(args)
    #   field_class = default_field_class
    #   field_class += ' action' if args[:include_forgot]
    #
    #   field_wrapper(name, field_class) do
    #     ui = []
    #     ui << @f.password_field(name, args)
    #     ui << semantic_icon('lock')
    #     ui << link_to(I18n.t('semantic_form.button.forgot_password'),
    #       args[:forgot_link], class: 'ui button') if args[:include_forgot]
    #     ui.join.html_safe
    #   end
    # end
    #
    # def phone_field(name, args = {})
    #   args = default_args(name).merge(args)
    #
    #   field_wrapper(name, 'ui right icon input labeled') do
    #     ui = []
    #     ui << content_tag(:div, args[:country_code], class: 'ui basic label')
    #     ui << @f.phone_field(name, args)
    #     ui << semantic_icon('tablet')
    #     ui.join.html_safe
    #   end
    # end

    def text_area(name, args = {})
      args = default_args(name).merge(args)

      field_wrapper = FieldWrapper.new(@f.object, name, false, args)
      field_wrapper.call do
        @f.text_area(name, args)
      end
    end

    def text_field(name, args = {})
      args = default_args(name).merge(args)

      field_wrapper = FieldWrapper.new(@f.object, name, false, args)
      field_wrapper.call do
        ui = []
        ui << @f.text_field(name, args)
        ui << semantic_icon(args[:icon_name])
        ui.join.html_safe
      end
    end

    private
      def default_args(name)
        {
          placeholder: I18n.t("semantic_form.placeholder.#{@model_name}.#{name}"),
          autocomplete: 'off'
        }
      end

    class FieldWrapper
      include ActionView::Context
      include ActionView::Helpers::TagHelper

      attr_accessor :model, :name, :args
      attr_writer :inline

      def initialize(model, name, inline, args = {})
        @model = model
        @name = name
        @inline = inline
        @args = args
      end

      def call(ui_klass = nil)
        klass_div = ['field']
        klass_div << 'inline' if inline?
        klass_div << 'errors' if has_errors?

        content_tag(:div, class: klass_div) do
          ui = []
          ui << content_tag(:div, class: ui_klass || default_field_class) do
            yield
          end

          ui << content_tag(:div, error_messages,
            class: 'ui basic red pointing prompt label transition visible') if has_errors?

          ui.join.html_safe
        end
      end

      private
        def default_field_class
          'ui left icon input'
        end

        def inline?
          @inline
        end

        def has_errors?
          model.errors.messages[name.to_sym].any?
        end

        def error_messages
          model.errors.messages[name.to_sym].join(', ')
        end
    end
  end

  def semantic_form_for(model_data, args = {})
    form_for(model_data, args) do |f|
      yield(FormDecorator.new(model_data.is_a?(Array) ? model_data.last : model_data, f))
    end
  end
end
