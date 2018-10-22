# frozen_string_literal: true

module FormHelper
  class ActionView::Helpers::FormBuilder
    include ActionView::Helpers::FormTagHelper
    include ActionView::Helpers::FormOptionsHelper
    include ActionView::Context

    UI_OPTIONS = [:hint, :label, :size, :hide_label]
    SELECT_OPTIONS = [:prompt, :include_blank]

    def ui_text_field(name, options = {})
      options = set_classname(name, options)
      ui_field_wrapper(name, text_field(name, extract_input_options(options)), options)
    end

    def ui_email_field(name, options = {})
      options = set_classname(name, options)
      ui_field_wrapper(name, email_field(name, extract_input_options(options)), options)
    end

    # TODO: add tests
    def ui_password_field(name, options = {})
      options = set_classname(name, options)
      ui_field_wrapper(name, password_field(name, extract_input_options(options)), options)
    end

    def ui_telephone_field(name, options = {})
      options = set_classname(name, options)
      ui_field_wrapper(name, telephone_field(name, extract_input_options(options)), options)
    end

    def ui_select_field(name, content, options = {})
      options = set_classname(name, options, 'select')
      ui_field_wrapper(name, select(name, content, only_select_options(options), extract_select_options(options)), options)
    end
  
    # TODO: add tests
    def ui_text_area(name, options = {})
      options = set_classname(name, options)
      ui_field_wrapper(name, text_area(name, extract_input_options(options)), options)
    end
    
    def ui_date_field(name, options = {})
      options = set_classname(name, options)
      ui_field_wrapper(name, date_field(object, name, extract_input_options(options)), options)
    end

    # TODO: add tests
    def ui_radio_button_field(name, value, options = {})
      options = set_classname(name, options, "radio")
      ui_field_wrapper(name, radio_button(name, value, extract_input_options(options)), options)
    end

    # TODO: add tests
    def ui_check_box(name, options = {})
      options = set_classname(name, options)
      options[:hide_label] = true

      # These are the visible labels displayed to the user
      label = content_tag(:span, options[:label], class: "ui-checkbox__label")
      checkbox_hint = content_tag(:span, options[:checkbox_hint], class: "ui-checkbox__hint")
      visible_label = content_tag(:div, label + checkbox_hint, class: "ui-checkbox__label-group")

      # This markup is required for our custom styled checkboxes
      content = content_tag :div, class: "ui-checkbox ui-checkbox--large" do
        check_box(name) +
        label(name, visible_label)
      end
      ui_field_wrapper(name, content, options)
    end

    def ui_field_wrapper(name, content, options = {})
      errors = error_messages(name)
      inline_help = hint_tag(options[:hint])
      inline_errors = error_tag(name, errors)
      inline_help = inline_help_tag(inline_help, inline_errors)
      label = !options[:hide_label] && label(name, options[:label], class: "ui-field-label")
      children = label ? label + content + inline_help : content + inline_help
      is_required = options[:required] || options["required"]

      content_tag(:div, children, class: "ui-field#{is_required ? " ui-field--required" : ""}")
    end

    private

      def error_tag(name, errors)
        errors = Array.wrap(errors)
        return nil if errors.empty?
        human_attr = object.class.human_attribute_name(name)
        return content_tag(:div, "#{human_attr} #{errors.first}".humanize, class: "ui-field-validation") if errors.length == 1
        content_tag(:div, class: "ui-field-validations") do
          errors.each { |e| concat content_tag(:div, "#{human_attr} #{e}".humanize, class: "ui-field-validation") }
        end
      end

      def hint_tag(hint)
        return nil if hint.nil?
        content_tag(:div, hint, class: "ui-field-hint")
      end

      def inline_help_tag(help, errors)
        errors || help || nil
      end

      def object
        @object.presence || @template.instance_variable_get("@#{@object_name}")
      end

      def error_messages(name)
        object.errors[name]
      end

      def set_classname(name, options = {}, tag = 'input')
        errors = error_messages(name)
        options[:class] = options[:class] ? "ui-#{tag} #{options[:class]}" : "ui-#{tag}"
        options[:class] = "#{options[:class]} ui-input--#{options[:size] || 'medium'}"
        options[:class] = options[:class] + " ui-input--invalid" if errors.any?
        options
      end

      def extract_input_options(options)
        options.except(*UI_OPTIONS)
      end

      def extract_select_options(options)
        extract_input_options(options).except(*SELECT_OPTIONS)
      end

      def only_select_options(options)
        options.slice(*SELECT_OPTIONS)
      end
  end
end
