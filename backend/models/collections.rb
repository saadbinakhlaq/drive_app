require_relative 'model'

class Cars < Application::ModelCollections
  assigns
  index :id

  def self.collect(data)
    insert Car.create(data)
  end
end

class Rentals < Application::ModelCollections
  assigns
  index :car_id

  def self.collect(data)
    insert Rental.create(data)
  end
end
