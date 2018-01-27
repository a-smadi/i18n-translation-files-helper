require "#{Rails.root}/lib/tasks/i18n-translation-files-helper/string_ops"

class TranslationRecord
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
    clean
    prepare_key
  end

  def valid?
    @key.present? && @value.present? && !@key.empty? && !@value.empty?
  end

  def as_row
    "  #{@key}: #{@value}"
  end

  private

  def clean
    @key = @key.to_s.strip
    @value = @value.to_s.strip
    @value = "'#{@value}'" if !@value.start_with?('\'') && value_has_variable?
  end

  def prepare_key
    @key = (@key[1..-1]).strip if @key.start_with?(':')
    @key = StringOps.underscore(@key)
  end

  def value_has_variable?
    @value.include?('%{') && (@value.index('}', @value.index('%{')) || -1).positive?
  end
end
