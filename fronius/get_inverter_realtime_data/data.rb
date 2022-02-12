class Fronius
  class GetInverterRealtimeData
    class Data < Fronius::Data
      def device_status
        Fronius::DeviceStatus.new(data["DeviceStatus"])
      end

      def timestamp
        Time.parse(head["Timestamp"])
      end

      private

      def data
        json["Body"]["Data"]
      end

      def head
        json["Head"]
      end
    end
  end
end
