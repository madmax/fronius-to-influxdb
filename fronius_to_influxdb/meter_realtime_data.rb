class FroniusToInfluxdb
  class MeterRealtimeData
    attr_reader :data
    def initialize(data)
      @data = data
    end

    def to_write_point
      {
        current_ac_phase_1: data.current_ac_phase_1,
        current_ac_phase_2: data.current_ac_phase_2,
        current_ac_phase_3: data.current_ac_phase_3,
        current_ac_sum: data.current_ac_sum,
        energy_reactive_v_ar_ac_sum_consumed: data.energy_reactive_v_ar_ac_sum_consumed,
        energy_reactive_v_ar_ac_sum_produced: data.energy_reactive_v_ar_ac_sum_produced,
        energy_real_wac_minus_absolute: data.energy_real_wac_minus_absolute,
        energy_real_wac_plus_absolute: data.energy_real_wac_plus_absolute,
        energy_real_wac_sum_consumed: data.energy_real_wac_sum_consumed,
        energy_real_wac_sum_produced: data.energy_real_wac_sum_produced,
        frequency_phase_average: data.frequency_phase_average,
        meter_location_current: data.meter_location_current,
        power_apparent_s_phase_1: data.power_apparent_s_phase_1,
        power_apparent_s_phase_2: data.power_apparent_s_phase_2,
        power_apparent_s_phase_3: data.power_apparent_s_phase_3,
        power_apparent_s_sum: data.power_apparent_s_sum,
        power_factor_phase_1: data.power_factor_phase_1,
        power_factor_phase_2: data.power_factor_phase_2,
        power_factor_phase_3: data.power_factor_phase_3,
        power_factor_sum: data.power_factor_sum,
        power_reactive_q_phase_1: data.power_reactive_q_phase_1,
        power_reactive_q_phase_2: data.power_reactive_q_phase_2,
        power_reactive_q_phase_3: data.power_reactive_q_phase_3,
        power_reactive_q_sum: data.power_reactive_q_sum,
        power_real_p_phase_1: data.power_real_p_phase_1,
        power_real_p_phase_2: data.power_real_p_phase_2,
        power_real_p_phase_3: data.power_real_p_phase_3,
        power_real_p_sum: data.power_real_p_sum,
        voltage_ac_phase_to_phase_12: data.voltage_ac_phase_to_phase_12,
        voltage_ac_phase_to_phase_23: data.voltage_ac_phase_to_phase_23,
        voltage_ac_phase_to_phase_31: data.voltage_ac_phase_to_phase_31,
        voltage_ac_phase_1: data.voltage_ac_phase_1,
        voltage_ac_phase_2: data.voltage_ac_phase_2,
        voltage_ac_phase_3: data.voltage_ac_phase_3
      }.each_with_object({}) { |(key, value), hash| hash[key] = value || 0.0 }
    end
  end
end
