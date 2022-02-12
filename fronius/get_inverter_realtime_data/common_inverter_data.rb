class Fronius
  class GetInverterRealtimeData
    class CommonInverterData < Fronius::GetInverterRealtimeData::Data
      expose :device_status, :day_energy, :iac, :idc, :idc_2, :idc_3, :pac, :sac, :total_energy, :uac, :udc, :udc_2, :udc_3, :year_energy

      %w(DAY_ENERGY IAC IDC IDC_2 IDC_3 PAC SAC TOTAL_ENERGY UAC UDC UDC_2 UDC_3 YEAR_ENERGY).each do |value_with_unit|
        define_method value_with_unit.downcase.to_sym do
          Fronius::ValueWithUnit.new(data[value_with_unit])
        end
      end
    end
  end
end
