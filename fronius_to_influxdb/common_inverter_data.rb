require_relative "common_inverter_data/device_status"

class FroniusToInfluxdb
  class CommonInverterData
    attr_reader :data
    def initialize(data)
      @data = data
    end

    def device_status
      FroniusToInfluxdb::CommonInverterData::DeviceStatus.new(data.device_status)
    end

    def to_write_point
      {
        iac: data.iac.value,
        idc: data.idc.value,
        idc_2: data.idc_2.value,
        idc_3: data.idc_3.value,
        pac: data.pac.value,
        sac: data.sac.value,
        total_energy: data.total_energy.value,
        uac: data.uac.value,
        udc: data.udc.value,
        udc_2: data.udc_2.value,
        udc_3: data.udc_3.value,
        year_energy:data.year_energy.value,
        day_energy: data.day_energy.value,
      }.each_with_object({}) { |(key, value), hash| hash[key] = value || 0.0 }
    end
  end
end
