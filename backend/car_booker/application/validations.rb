require 'date'

module Application
  module Validations
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def validate(attribute, options = {})
        callbacks = class_variables.find { |variable| variable == :@@callbacks }
        if callbacks.nil?
          callbacks = class_variable_set(:@@callbacks, [])
        else
          callbacks = class_variable_get(:@@callbacks)
        end
        
        if options[:presence]
          callbacks << {
            attribute: attribute,
            callback: :validate_presence
          }
        end
        
        if options[:numericality]
          callbacks << {
            attribute: attribute,
            callback: :validate_numericality
          }
        end
        
        if options[:date]
          callbacks << {
            attribute: attribute,
            callback: :validate_date
          }
        end
      end

      def validate_presence(attribute, value)
        raise PresenceError.new(attribute).to_s if value.nil?
      end

      def validate_numericality(attribute, value)
        raise NumericalityError.new(attribute).to_s unless value.is_a? Numeric
      end

      def validate_date(attribute, value)
        year, month, day = value.split('-')
        date_valid = Date.valid_date? year.to_i, month.to_i, day.to_i
        raise DateError.new(attribute).to_s unless date_valid
      end

      class CustomErrorClass < StandardError
        def initialize(obj)
          @obj = obj
        end
      end

      class PresenceError < StandardError
        def to_s
          "#{@obj} is not present"
        end
      end

      class NumericalityError < StandardError
        def to_s
          "#{@obj} is not a valid number"
        end
      end

      class DateError < StandardError
        def to_s
          "#{@obj} is not a valid date"
        end
      end
    end
  end
end