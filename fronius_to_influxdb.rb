#!/usr/bin/env ruby

require "bundler"
require "influxdb"
require "ostruct"

require_relative "fronius"
require_relative "fronius_to_influxdb/three_p_inverter_data"
require_relative "fronius_to_influxdb/common_inverter_data"

class FroniusToInfluxdb
  def config
    @config ||= OpenStruct.new YAML.load_file("config.yml")
  end

  def fronius
    @fronius ||=   Fronius.new config.fronius.fetch("url")
  end

  def influxdb
    @influxdb ||= InfluxDB::Client.new config.influxdb.fetch("database"),
      username: config.influxdb["username"],
      password: config.influxdb["password"],
      host: config.influxdb["host"]
  end

  def common_inverter_data
    CommonInverterData.new fronius.get_inverter_realtime_data.common_inverter_data
  end

  def three_p_inverter_data
    ThreePInverterData.new fronius.get_inverter_realtime_data.three_p_inverter_data
  end

  def write_point(measurement, values)
    influxdb.write_point(measurement, values: values)
    puts "measurement: #{measurement}, values: #{values}"
  end

  def run
    puts "Collecting fronius data..."
    loop do
      common_inverter_data = self.common_inverter_data
      three_p_inverter_data = self.three_p_inverter_data
      device_status = common_inverter_data.device_status

      unless device_status.sleeping?
        write_point('common_inverter_data', common_inverter_data.to_write_point)
        write_point('three_p_inverter_data', three_p_inverter_data.to_write_point)
        write_point('device_status', device_status.to_write_point)
      end

      sleep config.interval
    end
  end
end


FroniusToInfluxdb.new.run