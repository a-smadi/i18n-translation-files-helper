require 'rake'

task add_t: :environment do
  T_FILES_DIR = 'config/locales/'.freeze
  EN_FILE = 'en.yml'.freeze
  AR_FILE = 'ar.yml'.freeze
  ALPHABET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z].freeze

  ARGV.each do |a|
    task a.to_sym
  end
  key = ARGV[1].to_s.strip
  value = ARGV[2].to_s.strip

  abort('invalid key,value pair !') unless valid?(key, value)

  t_file = T_FILES_DIR + (english?(value) ? EN_FILE : AR_FILE)

  abort('translation file does not exist !') unless File.file?(t_file)

  key = prepare(key)
  key_word = "# #{key.slice(0).upcase} #"
  position = find_in_file(t_file, key_word) + 1

  abort('translation file is not properly formatted !') unless position.positive?

  row = "  #{key}: #{value}"
  add_row_to_file(t_file, key, position, row)
end

def valid?(key, value)
  key.present? && value.present? && !key.empty? && !value.empty?
end

def prepare(key)
  key = (key[1..-1]).strip if key.start_with?(':')
  key = underscore(key)
  key
end

def english?(value)
  value = value.tr(' ', '')
  score = 0
  value.chars.each { |char| score += (100.0 / value.size) if ALPHABET.include?(char.downcase) }
  score >= 75
end

def find_in_file(filename, text)
  count = 0
  File.open(filename, 'r') do |file|
    file.each_line do |line|
      count += 1
      return count if line.match?(/#{text}/)
    end
  end
  -1
end

def add_row_to_file(filename, key, line, text)
  open(filename, 'r+') do |file|
    line.times { file.readline }
    current_key = file.readline
    current_key = file.readline while skip_this_line?(key, current_key.strip)
    pos = file.pos
    remainder = file.read
    file.seek(pos)
    file.write("#{text}\n")
    file.write(remainder)
  end
end

def underscore(text)
  text.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').tr('-', '_').downcase
end

def skip_this_line?(key, current_key)
  key == [key, current_key.downcase].sort_by! { |text| text }.last
end
