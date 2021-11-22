require_relative './temp_scale_names'

class ScaleConverter
  include TempScaleNames

  @k = 273.15

  def initialize
    @k = 273.15
  end

  def from_kelvin(degree, to_scale)
    case to_scale
    when CELSIUS
      (degree - @k).round(2)
    when FAHRENHEIT
      ((degree - @k) * 1.8 + 32).round(2)
    end
  end

  def from_fahrenheit(degree, to_scale)
    case to_scale
    when CELSIUS
      ((degree - 32) / 1.8).round(2)
    when KELVIN
      ((degree - 32) / 1.8 + @k).round(2)
    end
  end

  def from_celsius(degree, to_scale)
    case to_scale
    when KELVIN
      (degree + @k).round(2)
    when FAHRENHEIT
      (degree * 1.8 + 32).round(2)
    end
  end

  def convert(degree, from_scale, to_scale)
    return degree if from_scale == to_scale

    case from_scale
    when CELSIUS
      from_celsius(degree, to_scale)
    when FAHRENHEIT
      from_fahrenheit(degree, to_scale)
    when KELVIN
      from_kelvin(degree, to_scale)
    end
  end
end
