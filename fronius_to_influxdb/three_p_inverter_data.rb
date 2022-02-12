class FroniusToInfluxdb
  class ThreePInverterData
    attr_reader :data
    def initialize(data)
      @data = data
    end

    def to_write_point
      {
        iac_l1: data.iac_l1.value,
        iac_l2: data.iac_l2.value,
        iac_l3: data.iac_l3.value,
        uac_l1: data.uac_l1.value,
        uac_l2: data.uac_l2.value,
        uac_l3: data.uac_l3.value
      }.each_with_object({}) { |(key, value), hash| hash[key] = value || 0 }
    end
  end
end
