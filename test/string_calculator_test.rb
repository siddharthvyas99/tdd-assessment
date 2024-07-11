require 'minitest/autorun'
require_relative '../lib/string_calculator'

class StringCalculatorTest < Minitest::Test
  def test_add_empty_string
    assert_equal 0, StringCalculator.add("")
  end

  def test_add_single_number
    assert_equal 1, StringCalculator.add("1")
  end

  def test_add_single_number_with_newline_or_comma_delimiters
    assert_equal 1, StringCalculator.add("1")
    assert_equal 1, StringCalculator.add("1\n")
    assert_equal 1, StringCalculator.add("1,")
  end

  def test_add_single_number_with_custom_delimiter
    assert_equal 1, StringCalculator.add("//;\n1")
    assert_equal 1, StringCalculator.add("//%\n1%")
    assert_equal 1, StringCalculator.add("//%\n%%%1%%%")
  end

  def test_add_two_numbers
    assert_equal 6, StringCalculator.add("1, 5")
  end

  def test_add_two_numbers_with_newline
    assert_equal 6, StringCalculator.add("1\n5")
  end

  def test_add_list_of_multiple_numbers
    assert_equal 160, StringCalculator.add("1, 5, 4, 10, 20, 30, 40, 50")
  end

  def test_add_list_of_multiple_numbers_with_newline_comma_delimiters
    assert_equal 160, StringCalculator.add("1, 5, 4, 10, 20, 30, 40, 50")
    assert_equal 160, StringCalculator.add("1\n 5\n 4\n 10\n 20\n 30\n 40\n 50")
    assert_equal 160, StringCalculator.add("1, 5\n 4, 10\n 20, 30\n 40, 50")
    assert_equal 160, StringCalculator.add("1\n 5, 4\n 10\n 20, 30\n 40, 50")
  end

  def test_add_list_of_multiple_numbers_with_newline_comma_delimiters
    assert_equal 160, StringCalculator.add("1, 5, 4, 10, 20, 30, 40, 50")
    assert_equal 160, StringCalculator.add("1\n 5\n 4\n 10\n 20\n 30\n 40\n 50")
    assert_equal 160, StringCalculator.add("1, 5\n 4, 10\n 20, 30\n 40, 50")
    assert_equal 160, StringCalculator.add("1\n 5, 4\n 10\n 20, 30\n 40, 50")
  end

  def test_add_list_of_multiple_numbers_with_custom_newline_and_comma_delimiters
    assert_equal 160, StringCalculator.add("//$\n1, 5$ 4, 10, 20$ 30, 40, 50")
    assert_equal 160, StringCalculator.add("//$\n1\n 5$ 4\n 10, 20$ 30\n 40$ 50")
  end
end