require 'minitest/autorun'
require_relative '../lib/string_calculator'

class StringCalculatorTest < Minitest::Test
  def test_add_empty_string
    assert_equal 0, StringCalculator.add("")
  end

  def test_add_single_number
    assert_equal 1, StringCalculator.add("1")
  end

  def test_add_two_numbers
    assert_equal 6, StringCalculator.add("1, 5")
  end

  def test_add_list_of_multiple_numbers
    assert_equal 160, StringCalculator.add("1, 5, 4, 10, 20, 30, 40, 50")
  end
end