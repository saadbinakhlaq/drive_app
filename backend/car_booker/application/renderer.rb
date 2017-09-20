module Application
  class Renderer
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def render(format:)
      if format == :json
        puts value.to_json
      else
        raise UnknownFormatError.new(format).to_s
      end
    end

    class UnknownFormatError < StandardError
      def initialize(obj)
        @obj = obj
      end

      def to_s
        "#{obj} format is not supportde"
      end
    end
  end
end