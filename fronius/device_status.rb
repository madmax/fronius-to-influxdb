class Fronius
  DeviceStatus = Struct.new(:error_code, :inverter_state, :status_code) do
    def initialize(data)
      super(data["ErrorCode"], data["InverterState"], data["StatusCode"])
    end
  end
end
