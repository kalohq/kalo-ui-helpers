module AvatarHelper
  def ui_avatar_fallback_initials(name = "")
    return nil unless name.present?
    parts = name.split(" ")
    return "#{name[0]}#{name[-1]}".upcase unless parts.length > 1
    "#{parts.first[0]}#{parts.last[0]}".upcase
  end

  def ui_avatar_fallback_color(s = "")
    return "navy" unless s.present?
    colors = %w(orange pink green blue navy)
    code_points_sum = s.chars.map(&:ord).reduce(0, :+)
    colors[code_points_sum % colors.length || -1]
  end

  def ui_avatar(options = {})
    fallback_color = options[:fallback_color] || 'navy'
    fallback_initials = options[:fallback_initials] || nil
    size = options[:size] || 'medium'
    name = options[:name] || nil
    is_grouped = options[:is_grouped] || false
    optional_classes = *options[:class]
    classes = ["ui-avatar ui-avatar--#{size}", "ui-avatar--fallback-#{fallback_color}", ("ui-avatar--grouped" if is_grouped)]
    if optional_classes
      classes += optional_classes
    end

    content_tag(
      :span,
      'aria-label': name,
      'data-fallback-initials': fallback_initials,
      class: classes,
      role: 'img'
    ) do
      content_tag(:span, nil, class: "ui-avatar__avatar", style: ("background-image: url(#{options[:src]})" if options[:src].present?))
    end
  end

  def ui_avatar_group(options = {}, &block)
    return nil unless block_given?
    avatars = capture(&block)
    chip_size = options[:chip_size] || "medium"
    overflow_chip = options[:overflow] ? content_tag(:span,
      options[:overflow],
      class: "ui-avatar-group__chip ui-avatar--#{chip_size}",
    ) : nil
    
    content_tag(:div, class: "ui-avatar-group") do
      [avatars, overflow_chip].join.html_safe
    end
  end
end