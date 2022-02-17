class Fronius
  class GetMeterRealtimeData < Fronius::Data
    [
      "Current_AC_Phase_1",
      "Current_AC_Phase_2",
      "Current_AC_Phase_3",
      "Current_AC_Sum",
      "Enable",
      "EnergyReactive_VArAC_Sum_Consumed",
      "EnergyReactive_VArAC_Sum_Produced",
      "EnergyReal_WAC_Minus_Absolute",
      "EnergyReal_WAC_Plus_Absolute",
      "EnergyReal_WAC_Sum_Consumed",
      "EnergyReal_WAC_Sum_Produced",
      "Frequency_Phase_Average",
      "Meter_Location_Current",
      "PowerApparent_S_Phase_1",
      "PowerApparent_S_Phase_2",
      "PowerApparent_S_Phase_3",
      "PowerApparent_S_Sum",
      "PowerFactor_Phase_1",
      "PowerFactor_Phase_2",
      "PowerFactor_Phase_3",
      "PowerFactor_Sum",
      "PowerReactive_Q_Phase_1",
      "PowerReactive_Q_Phase_2",
      "PowerReactive_Q_Phase_3",
      "PowerReactive_Q_Sum",
      "PowerReal_P_Phase_1",
      "PowerReal_P_Phase_2",
      "PowerReal_P_Phase_3",
      "PowerReal_P_Sum",
      "TimeStamp",
      "Visible",
      "Voltage_AC_PhaseToPhase_12",
      "Voltage_AC_PhaseToPhase_23",
      "Voltage_AC_PhaseToPhase_31",
      "Voltage_AC_Phase_1",
      "Voltage_AC_Phase_2",
      "Voltage_AC_Phase_3"
    ].each do |field|

      field_normalized = field.underscore.to_sym

      @_expose ||= []
      @_expose << field_normalized

      define_method field_normalized do
        data[field]
      end
    end

    expose(*@_expose)

    def self.fetch(api)
      new api.get("GetMeterRealtimeData.cgi")
    end

    def data
      json.dig("Body", "Data", "0")
    end
  end
end
