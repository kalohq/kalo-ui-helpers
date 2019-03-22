module AvatarHelper
  def UIAvatar(options = {})
    fallbackColor = options[:fallbackColor] || 'navy'
    fallbackInitials = options[:fallbackInitials] || nil
    size = options[:size] || 'medium'
    name = options[:name] || nil
    isGrouped = options[:isGrouped] || false

    avatarImage = content_tag(:span, '', class: "ui-avatar__avatar", style: "background-image: url(#{options[:src]})").html_safe

    content_tag(:span,
      avatarImage,
      'aria-label': name,
      'data-fallback-initials': fallbackInitials,
      class: "ui-avatar ui-avatar--#{size} ui-avatar--fallback-#{fallbackColor} #{isGrouped && 'ui-avatar--grouped'}",
      role: 'img'
    ).html_safe
  end

  def UIAvatarGroup(options = {})
    chipSize = options[:avatars] ? options[:avatars].last[:size] : nil
    overflowChip = content_tag(:span,
      options[:overflow],
      class: "ui-avatar-group__chip ui-avatar--#{chipSize}",
    ).html_safe

     if (options[:avatars])
      content_tag(:div, :nil, class: "ui-avatar-group" ) {
        options[:avatars].each do |avatar|
          avatar[:isGrouped] = true
          concat UIAvatar(avatar)
        end
        concat overflowChip
      }.html_safe
    end

  end
  
end