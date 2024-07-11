class StringCalculator
  def self.add(numbers_list)
    # Nil Case "", nil
    return 0 if numbers_list.empty? || numbers_list.nil?

    # Case "1", returns 1
    return numbers_list.to_i unless numbers_list.include? ","

    # Add Input: “1,5”, Output: 6
    numbers = numbers_list.split(",").map(&:to_i)
    numbers.reduce(0, :+)
  end  
end