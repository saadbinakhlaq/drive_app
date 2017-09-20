module Application
  module Collections
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def assigns
        class_variable_set(:@@collection, [])
      end

      def index(value)
        value = value ? value : :id
        class_variable_set(:@@index, value)
      end

      def get(object_id)
        collection = class_variable_get(:@@collection)
        collection.bsearch { |object| object.id >= object_id }
      end

      def insert(object)
        collection  = class_variable_get(:@@collection)
        index = class_variable_get(:@@index)

        collection << object
        collection.sort! { |obj_1, obj_2| obj_1.send(index) <=> obj_2.send(index) }
      end
    end
  end

  class ModelCollections
    include Collections
    
    def self.data
      class_variable_get(:@@collection)
    end
  end
end