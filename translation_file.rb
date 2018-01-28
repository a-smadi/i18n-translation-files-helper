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
      prev = file.pos
      current_key = file.readline
      pos = file.pos
      while skip_this_line?(key, current_key.strip)
        prev = pos
        current_key = file.readline
        pos = file.pos
      end
      file.seek(prev)
      remainder = file.read
      file.seek(prev)
      file.write("#{row}\n" + remainder)
    end
  end

  def self.suitable_t_file(text)
    T_FILES_ROOT + (StringOps.english?(text) ? EN_FILE : AR_FILE)
  end

  def self.translation_filename(locale)
    locale == 'EN' ? T_FILES_ROOT + EN_FILE : T_FILES_ROOT + AR_FILE
  end

  private

  def skip_this_line?(key, current_key)
    return false if current_key.start_with?('#')
    key == [key, current_key.downcase].sort_by! { |text| text }.last
  end
end
