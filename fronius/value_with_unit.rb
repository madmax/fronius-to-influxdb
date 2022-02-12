class Fronius
  ValueWithUnit = Struct.new(:value, :unit) do
    def initialize(data)
      super(data["Value"], data["Unit"])
    end
  end
end
