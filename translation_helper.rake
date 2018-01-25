require 'rake'
require "#{Rails.root}/lib/tasks/i18n-translation-files-helper/translation_file"
require "#{Rails.root}/lib/tasks/i18n-translation-files-helper/translation_record"

task add_t: :environment do
  ARGV.each { |arg| task arg.to_sym }
  t_record = TranslationRecord.new(ARGV[1], ARGV[2])

  abort('invalid key,value pair !') unless t_record.valid?

  t_file = TranslationFile.new(TranslationFile.suitable_t_file(t_record.value))

  abort('translation file does not exist !') unless t_file.exists?

  position = t_file.find("# #{t_record.key.slice(0).upcase} #") + 1

  abort('translation file is not properly formatted !') unless position.positive?

  t_file.add(t_record.as_row, position, t_record.key)
end
