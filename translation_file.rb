require "#{Rails.root}/lib/tasks/i18n-translation-files-helper/string_ops"

class TranslationFile
  T_FILES_ROOT = 'config/locales/'.freeze
  EN_FILE = 'en.yml'.freeze
  AR_FILE = 'ar.yml'.freeze

  def initialize(filename)
    @filename = filename
  end

  def exists?
    File.file?(@filename)
  end

  def find(keyword)
    count = 0
    File.open(@filename, 'r') do |file|
      file.each_line do |line|
        count += 1
        return count if line.match?(/#{keyword}/)
      end
    end
    -1
  end

  def add(row, position, key)
    open(@filename, 'r+') do |file|
      position.times { file.readline }
      current_key = file.readline
      current_key = file.readline while skip_this_line?(key, current_key.strip)
      pos = file.pos
      remainder = file.read
      file.seek(pos)
      file.write("#{row}\n")
      file.write(remainder)
    end
  end

  def self.suitable_t_file(text)
    T_FILES_ROOT + (StringOps.english?(text) ? EN_FILE : AR_FILE)
  end

  private

  def skip_this_line?(key, current_key)
    key == [key, current_key.downcase].sort_by! { |text| text }.last
  end
end
