class FroniusToInfluxdb
  class CommonInverterData

    class DeviceStatus
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def sleeping?
        data.inverter_state == "Sleeping"
      end

      def to_write_point
        {
          error_code: data.error_code,
          inverter_state: data.inverter_state,
          status_code: data.status_code
        }.each_with_object({}) { |(key, value), hash| hash[key] = value || 0 }
      end
    end
  end
end
