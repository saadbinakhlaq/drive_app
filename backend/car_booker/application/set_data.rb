module Application
  module SetData
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def set_data(array = [])
        class_variable_set(:@@list_of_attributes, array.map(&:to_sym))
      end
    end
  end
end