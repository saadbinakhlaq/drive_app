require 'pry'
class Algorithm
  def initialize(*values)
    @values = values
  end
end

class Multiply < Algorithm
  def result
    @values.inject { |product, value| product *value }
  end
end

class Add < Algorithm
  def result
    @values.inject { |sum, value| sum += value }
  end
end

class Discount
  attr_reader :value,
              :discount

  def initialize(value, discount)
    @value    = value
    @discount = discount
  end

  def result
    discount_value = (discount/100.0 * value)
    value - discount_value
  end
end


discount = {
  1 => 10, 4 => 30, 10 => 50
}

class DefineRules
  attr_reader :discount
  attr_accessor :number_of_days

  def initialize(discount, number_of_days)
    @discount = discount
    @number_of_days = number_of_days
  end

  def result
    discount_ranges = discount.keys
    n = number_of_days
    Struct.new('Rule', :lower, :upper, :discount_percentage, :number_of_days)
    binding.pry

    discount_ranges.unshift(0)
    final_index = discount_ranges.size - 1
    discount_ranges.map do |item|
      index = discount_ranges.index(item)
      rules = []

      rule = 
        if index == 0
          lower = 0
          upper = discount_ranges[index + 1]
          days_between = upper - lower
          if n >= days_between
            n = n - days_between
            Struct::Rule.new(0, upper, 0, days_between)
          else
            r = Struct::Rule.new(0, upper, 0, n)
            n = 0
            r
          end
        elsif index == final_index
          Struct::Rule.new(item + 1, 10/0.0, discount[item], n)
        else
          lower = item + 1
          upper = discount_ranges[index + 1]
          days_between = upper - lower + 1
          if n >= days_between
            n = n - days_between
            Struct::Rule.new(lower, upper, discount[item], days_between)
          else
            r = Struct::Rule.new(lower, upper, discount[item], n)
            n = 0
            r
          end
        end
      rule  
    end
  end
end

p DefineRules.new(discount, 30).result