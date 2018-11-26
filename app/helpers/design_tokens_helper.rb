module DesignTokensHelper
  def design_tokens
    tokens = File.read(
      Rails.root.join("node_modules", "@kalo", "ui", "lib", "design-tokens", "tokens.json")
    )
    JSON.parse(tokens, symbolize_names: true)
  end
end