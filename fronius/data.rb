class Fronius
  class Data
    attr_reader :json

    def self.expose(*attributes)
      @attributes = attributes
    end

    def self.attributes
      @attributes
    end

    def initialize(json)
      @json = json
    end

    def inspect
      "#<#{self.class} #{attributes}>"
    end

    def attributes
      return "" if self.class.attributes.nil?

      self.class.attributes.map do |attribute|
        "#{attribute}: = #{public_send(attribute)}"
      end.join(", ")
    end
  end
end
