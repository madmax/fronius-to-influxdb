#!/usr/bin/env ruby

require "bundler"
require "influxdb"
require "ostruct"
require "yaml"
require "retriable"

require_relative "fronius"
require_relative "fronius_to_influxdb/three_p_inverter_data"
require_relative "fronius_to_influxdb/common_inverter_data"
require_relative "fronius_to_influxdb/meter_realtime_data"

class FroniusToInfluxdb
  def config
    @config ||= OpenStruct.new YAML.load_file("config.yml")
  end

  def fronius
    @fronius ||= Fronius.new config.fronius.fetch("url")
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

  def meter_realtime_data
    MeterRealtimeData.new fronius.get_meter_realtime_data
  end

  def write_point(measurement, values)
    influxdb.write_point(measurement, values: values)
    puts "measurement: #{measurement}, values: #{values}"
  end

  def on_retry
    Proc.new do |exception, try, elapsed_time, next_interval|
      puts "#{exception.class}: '#{exception.message}' - #{try} tries in #{elapsed_time} seconds and #{next_interval} seconds until the next try."
    end
  end

  def collect
    Retriable.retriable(tries: 5, base_interval: 10, on_retry: on_retry)  do
      common_inverter_data = self.common_inverter_data
      three_p_inverter_data = self.three_p_inverter_data
      device_status = common_inverter_data.device_status
      meter_realtime_data = self.meter_realtime_data

      write_point('common_inverter_data', common_inverter_data.to_write_point)
      write_point('three_p_inverter_data', three_p_inverter_data.to_write_point)
      write_point('device_status', device_status.to_write_point)
      write_point('meter_realtime_data', meter_realtime_data.to_write_point)
    end
  end

  def run
    puts "Collecting fronius data..."
    loop do
      collect
      sleep config.interval
    end
  end
end

fronius_to_influxdb = FroniusToInfluxdb.new
fronius_to_influxdb.run
