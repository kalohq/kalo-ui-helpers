module IconHelper
  def icon(asset, options = {})
    file = File.read(Rails.root.join("node_modules", "@kalo", "ui", "lib", "icons", "svg", "#{asset}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"

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
      svg["fill"] = options[:fill]
    end

    doc.to_html.html_safe
  end
end