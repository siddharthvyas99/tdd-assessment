# frozen_string_literal: true

require 'byebug'
class StringCalculator
  DELIMITER_LIST = /,|\n/.freeze

  def add(numbers_list)
    # Nil Case "", nil
    return 0 if numbers_list.empty? || numbers_list.nil?

    # Case "1", returns 1
    if numbers_list.split(DELIMITER_LIST).count < 2 && !numbers_list.start_with?('//') && !numbers_list.to_i.negative?
      return numbers_list.to_i
    end

    # Add Input: “1,5”, Output: 6
    if numbers_list.start_with?('//')
      custom_delimiter, numbers_list = parse_custom_delimiter_with_numbers_list(numbers_list)
    end
    custom_delimiter ||= ''

    delimiter_list = add_delimiter_to_existing_delimiter_list(custom_delimiter)

    numbers = numbers_list.split(delimiter_list).map(&:to_i)

    # Handle case for negative numbers
    handle_negative_numbers(numbers)

    numbers.reduce(0, :+)
  end

  private

  def parse_custom_delimiter_with_numbers_list(input)
    custom_delimiter, numbers_list = input.match(%r{//(.+)\n((.|\n)*)}).captures

    [custom_delimiter, numbers_list]
  end

  def add_delimiter_to_existing_delimiter_list(new_delimiter)
    return DELIMITER_LIST if new_delimiter.empty?

    # Escape the new delimiter to handle special characters
    escaped_delimiter = Regexp.escape(new_delimiter)

    # Append the new delimiter to the base pattern
    modified_pattern = "#{DELIMITER_LIST.source}|#{escaped_delimiter}"

    Regexp.new(modified_pattern)
  end

  def handle_negative_numbers(numbers)
    negative_numbers = numbers.select(&:negative?)

    return if negative_numbers.empty?

    raise "Negative numbers not allowed: #{negative_numbers.join(', ')}"
  end
end
