require_relative "get_inverter_realtime_data/data"
require_relative "get_inverter_realtime_data/three_p_inverter_data"
require_relative "get_inverter_realtime_data/common_inverter_data"
require_relative "get_inverter_realtime_data/cumulation_inverter_data"

class Fronius
  class GetInverterRealtimeData
    attr_reader :api

    def initialize(api)
      @api = api
    end

    def three_p_inverter_data
      ThreePInverterData.new get("3PInverterData")
    end

    def common_inverter_data
      CommonInverterData.new get("CommonInverterData")
    end

    def cumulation_inverter_data
      CumulationInverterData.new get("CumulationInverterData")
    end

    def get(collection)
      api.get("GetInverterRealtimeData.cgi", {"DataCollection" => collection, "Scope" => "Device", "DeviceId" => 1})
    end
  end
end
