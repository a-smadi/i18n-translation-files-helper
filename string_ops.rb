class StringOps
  ALPHABET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9].freeze

  def self.underscore(text)
    text.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').tr('-', '_').downcase
  end

  def self.english?(text)
    text = text.tr(' ', '')
    score = 0
    text.chars.each { |char| score += (100.0 / text.size) if ALPHABET.include?(char.downcase) }
    score >= 75
  end
end
