require 'rake'
require "#{Rails.root}/lib/tasks/i18n-translation-files-helper/translation_file"
require "#{Rails.root}/lib/tasks/i18n-translation-files-helper/translation_record"

task add_t: :environment do
  ARGV.each { |arg| task arg.to_sym }

  [ARGV[2], ARGV[3]].each do |value|
    next unless value.present?

    record = TranslationRecord.new(ARGV[1], value)

    abort('invalid key,value pair !') unless record.valid?

    t_file = TranslationFile.new(TranslationFile.suitable_t_file(record.value))

    abort('translation file does not exist !') unless t_file.exists?

    position = t_file.find("# #{record.key.slice(0).upcase} #") + 1

    abort('translation file is not properly formatted !') unless position.positive?

    t_file.add(record.as_row, position, record.key)
  end
end
