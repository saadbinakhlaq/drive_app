require_relative 'processing_algorithms'

class BookingCharges
  attr_reader :cars,
              :rentals

  def initialize(cars, rentals)
    @cars    = cars
    @rentals = rentals
  end

  def process(level:, discount:)
    case level
    when 1
      process_level_1
    when 2
      process_level_2 discount
    end
  end

  private

  def total_charges_per_unit(value_1, value_2)
    Multiply.new(value_1, value_2).result
  end

  def cumulative_charges(value_1, value_2)
    Add.new(value_1, value_2).result
  end

  def process_level_1
    output = { rentals: [] }

    rentals.data.each do |rental|
      car = cars.get rental.car_id
      next if car.nil?

      total_charges_for_distance = total_charges_per_unit(rental.distance, car.price_per_km)
      total_charges_for_days     = total_charges_per_unit(rental.number_of_days, car.price_per_day)
      output[:rentals] << {
        id: rental.id,
        price: cumulative_charges(total_charges_for_distance, total_charges_for_days)
      }
    end

    output
  end

  def process_level_2(discount)
    output = { rentals: [] }

    rentals.data.each do |rental|
      car = cars.get rental.car_id
      next if car.nil?

      total_charges_for_distance = total_charges_per_unit(rental.distance, car.price_per_km)
      discounted_price           = add_discount_by_days(car.price_per_day, discount, rental.number_of_days)
      output[:rentals] << {
        id: rental.id,
        price: cumulative_charges(total_charges_for_distance, discounted_price)
      }
    end

    output
  end

  def add_discount_by_days(charges_per_day, discount, number_of_days)
    rules = DefineRules.new(discount).result
    amount = charges_per_day

    rules.each do |rule|
      case number_of_days
      when 1
      when Range.new(rule.lower, rule.upper)
        amount += ()
      end
    end
  end
end