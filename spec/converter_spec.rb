require_relative '../lib/scale_converter'
require_relative '../lib/enums/temp_scale_names'

class Test
  include TempScaleNames

  RSpec.describe ScaleConverter do
    describe 'convert_from_kelvin' do
      context 'convert kelvin to fahrenheit' do
        it { expect(ScaleConverter.new.from_kelvin(0, FAHRENHEIT)).to eq(-459.67) }
      end
    end

    describe 'convert_from_kelvin' do
      context 'convert kelvin to celsius' do
        it { expect(ScaleConverter.new.from_kelvin(0, CELSIUS)).to eq(-273.15) }
      end
    end

    describe 'convert_from_fahrenheit' do
      context 'convert fahrenheit to celsius' do
        it { expect(ScaleConverter.new.from_fahrenheit(0, CELSIUS)).to eq(-17.78) }
      end
    end

    describe 'convert_from_fahrenheit' do
      context 'convert fahrenheit to kelvin' do
        it { expect(ScaleConverter.new.from_fahrenheit(0, KELVIN)).to eq 255.37 }
      end
    end

    describe 'convert_from_celsius' do
      context 'convert celsius to kelvin' do
        it { expect(ScaleConverter.new.from_celsius(0, KELVIN)).to eq 273.15 }
      end
    end

    describe 'convert_from_celsius' do
      context 'convert celsius to fahrenheit' do
        it { expect(ScaleConverter.new.from_celsius(0, FAHRENHEIT)).to eq 32.0 }
      end
    end

    describe 'ScaleConverter' do
      context 'celsius to fahrenheit' do
        it { expect(ScaleConverter.new.convert(0, CELSIUS, FAHRENHEIT)).to eq 32.0 }
      end

      context 'celsius to kelvin' do
        it { expect(ScaleConverter.new.convert(0, CELSIUS, KELVIN)).to eq 273.15 }
      end

      context 'fahrenheit to celsius' do
        it { expect(ScaleConverter.new.convert(0, FAHRENHEIT, CELSIUS)).to eq(-17.78) }
      end

      context 'fahrenheit to kelvin' do
        it { expect(ScaleConverter.new.convert(0, FAHRENHEIT, KELVIN)).to eq 255.37 }
      end

      context 'kelvin from celsius' do
        it { expect(ScaleConverter.new.convert(0, KELVIN, CELSIUS)).to eq(-273.15) }
      end

      context 'kelvin from fahrenheit' do
        it { expect(ScaleConverter.new.convert(0, KELVIN, FAHRENHEIT)).to eq(-459.67) }
      end
    end
  end
end
