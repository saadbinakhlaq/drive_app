require_relative '../car_booker/application'
require_relative '../models/collections'
require_relative '../services/booking_charges'

data = Application::InteractiveInputHandler.read 'data.json'

rentals = data['rentals']
cars    = data['cars']

rentals.each do |rental|
  Rentals.collect rental
end

cars.each do |car|
  Cars.collect car
end

charges = BookingCharges.new(Cars, Rentals).process level: 1
Application::Renderer.new(charges).render format: :json