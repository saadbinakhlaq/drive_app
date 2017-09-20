require_relative '../car_booker/application'

class Car < Application::Model
  set_data %w(
    id
    price_per_day
    price_per_km
  )

  validate :id,
           presence: true,
           numericality: true
  validate :price_per_km,
           presence: true,
           numericality: true
  validate :price_per_day,
           presence: true,
           numericality: true
end

class Rental < Application::Model
  set_data %w(
    id
    car_id
    start_date
    end_date
    distance
  )

  validate :id,
           presence: true,
           numericality: true
  validate :car_id,
           presence: true
  validate :start_date,
           presence: true,
           date: true
  validate :end_date,
           presence: true,
           date: true
  validate :distance,
           presence: true,
           numericality: true

  def number_of_days
    Date.parse(end_date).mjd - Date.parse(start_date).mjd + 1
  end         
end