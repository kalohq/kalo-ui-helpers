module IconHelper
  def icon(asset, options = {})
    file = File.read(Rails.root.join("node_modules", "@kalo", "ui", "lib", "icons", "svg", "#{asset}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"

    gradient_pink = '<defs><linearGradient id="gradient-pink"><stop offset="0%" stop-color="rgb(232, 63, 148)" /><stop offset="50%" stop-color="rgb(245, 78, 94)" /></linearGradient></defs>'

    if options[:class].present?
      svg["class"] = options[:class]
    end

    if options[:width].present?
      svg["width"] = options[:width]
    end

    if options[:height].present?
      svg["height"] = options[:height]
    end

    if options[:fill].present?
      if options[:fill].match(/^(gradient-).*/)
        case options[:fill]
        when "gradient-pink"
          svg[:fill] = "url(#gradient-pink)"
          svg.add_child(gradient_pink)
        else
          svg[:fill] = options[:fill]
        end
      else 
        svg[:fill] = options[:fill]
      end
    end

    doc.to_html.html_safe
  end
end