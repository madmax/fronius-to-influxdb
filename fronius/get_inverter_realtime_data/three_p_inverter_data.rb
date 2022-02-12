class Fronius
  class GetInverterRealtimeData
    class ThreePInverterData < Fronius::GetInverterRealtimeData::Data
      expose :iac_l1, :iac_l2, :iac_l3, :uac_l1, :uac_l2, :uac_l3

      %w(IAC_L1 IAC_L2 IAC_L3 UAC_L1 UAC_L2 UAC_L3).each do |value_with_unit|
        define_method value_with_unit.downcase.to_sym do
          Fronius::ValueWithUnit.new(data[value_with_unit])
        end
      end
    end
  end
end
