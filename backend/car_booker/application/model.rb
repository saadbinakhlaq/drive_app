require_relative 'set_data'
require_relative 'validations'

module Application
  class Model
    include SetData
    include Validations

    def initialize(options = {})
      list_of_attributes = self.class.class_variable_get(:@@list_of_attributes)
      
      list_of_attributes.each do |attribute|
        instance_variable_set("@#{attribute}", options[attribute.to_s] || options[attribute])
      end

      singleton_class.class_eval  { attr_accessor *list_of_attributes }
    end

    def self.create(options = {})
      run_callbacks options
      obj = new options
      obj
    end

    private_class_method :new

    private

    def self.run_callbacks(options)
      callbacks = class_variable_get(:@@callbacks)
      callbacks.each do |callback|
        attr = callback[:attribute]
        send(callback[:callback], callback[:attribute], options[attr.to_s] || options[attr])
      end
    end
  end
end