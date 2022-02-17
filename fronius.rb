require "bundler"
require "faraday"
require "faraday_middleware"
require "json"

require_relative "fronius/core_ext/string"
require_relative "fronius/value_with_unit"
require_relative "fronius/device_status"
require_relative "fronius/data"
require_relative "fronius/api"
require_relative "fronius/get_inverter_realtime_data"
require_relative "fronius/get_meter_realtime_data"

class Fronius
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def api
    @api ||= API.new(url)
  end

  def get_inverter_realtime_data
    @get_inverter_realtime_data ||= GetInverterRealtimeData.new(api)
  end

  def get_meter_realtime_data
    @get_meter_realtime_data ||= GetMeterRealtimeData.fetch(api)
  end
end
