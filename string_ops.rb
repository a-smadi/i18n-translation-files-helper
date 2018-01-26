class StringOps
  ALPHABET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z].freeze

  def self.underscore(text)
    text.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').tr('-', '_').downcase
  end

  def self.english?(text)
    text = letters_only(text)
    return true unless text.present? && !text.empty?
    score = 0
    text.chars.each { |char| score += (100.0 / text.size) if ALPHABET.include?(char) }
    score >= 50
  end

  private_class_method

  def self.letters_only(text)
    text.gsub(/[^0-9A-Za-z]/, '').tr('0-9', '').strip.downcase
  end
end
