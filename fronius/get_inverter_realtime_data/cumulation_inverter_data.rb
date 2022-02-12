class Fronius
  class GetInverterRealtimeData
    class CumulationInverterData < Fronius::GetInverterRealtimeData::Data
      expose :year_energy, :total_energy, :day_energy, :pac, :device_status, :timestamp

      %w(DAY_ENERGY TOTAL_ENERGY YEAR_ENERGY PAC).each do |value_with_unit|
        define_method value_with_unit.downcase.to_sym do
          Fronius::ValueWithUnit.new(data[value_with_unit])
        end
      end
    end
  end
end
