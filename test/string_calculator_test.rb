# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/string_calculator'

class StringCalculatorTest < Minitest::Test
  def setup
    @string_calculator = StringCalculator.new
  end

  def test_add_empty_string
    assert_equal 0, @string_calculator.add('')
  end

  def test_add_single_number
    assert_equal 1, @string_calculator.add('1')
  end

  def test_add_single_number_with_newline_or_comma_delimiters
    assert_equal 1, @string_calculator.add('1')
    assert_equal 1, @string_calculator.add("1\n")
    assert_equal 1, @string_calculator.add('1,')
  end

  def test_add_single_negative_number_with_newline_or_comma_delimiters_raises_exception
    exception = assert_raises(RuntimeError) { @string_calculator.add('-1') }
    assert_equal 'Negative numbers not allowed: -1', exception.message

    exception = assert_raises(RuntimeError) { @string_calculator.add('-1,') }
    assert_equal 'Negative numbers not allowed: -1', exception.message
  end

  def test_add_single_number_with_custom_delimiter
    assert_equal 1, @string_calculator.add("//;\n1")
    assert_equal 1, @string_calculator.add("//%\n1%")
    assert_equal 1, @string_calculator.add("//%\n%%%1%%%")
  end

  def test_add_two_numbers
    assert_equal 6, @string_calculator.add('1, 5')
  end

  def test_add_two_numbers_with_newline
    assert_equal 6, @string_calculator.add("1\n5")
  end

  def test_add_list_of_multiple_numbers
    assert_equal 160, @string_calculator.add('1, 5, 4, 10, 20, 30, 40, 50')
  end

  def test_add_list_of_multiple_numbers_with_newline_comma_delimiters
    assert_equal 160, @string_calculator.add('1, 5, 4, 10, 20, 30, 40, 50')
    assert_equal 160, @string_calculator.add("1\n 5\n 4\n 10\n 20\n 30\n 40\n 50")
    assert_equal 160, @string_calculator.add("1, 5\n 4, 10\n 20, 30\n 40, 50")
    assert_equal 160, @string_calculator.add("1\n 5, 4\n 10\n 20, 30\n 40, 50")
  end

  def test_add_list_of_multiple_numbers_with_custom_newline_and_comma_delimiters
    assert_equal 160, @string_calculator.add("//$\n1, 5$ 4, 10, 20$ 30, 40, 50")
    assert_equal 160, @string_calculator.add("//$\n1\n 5$ 4\n 10, 20$ 30\n 40$ 50")
  end

  def test_add_list_of_multiple_numbers_including_negatives_with_all_delimiters_combinations_raising_exception
    exception = assert_raises(RuntimeError) { @string_calculator.add("//$\n1, 5$ -4, 10, 20$ 30, 40, -50") }
    assert_equal 'Negative numbers not allowed: -4, -50', exception.message

    exception = assert_raises(RuntimeError) { @string_calculator.add("//$\n1\n -5$ 4\n 10, -20$ 30\n -40$ 50") }
    assert_equal 'Negative numbers not allowed: -5, -20, -40', exception.message
  end
end
