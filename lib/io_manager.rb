require_relative './enums/_states'
require_relative './enums/temp_scale_names'
require_relative './scale_converter'

class IOManager
  include IOStates
  include TempScaleNames

  @current_state = READ_FROM_TEMP_SCALE

  def self.valid_scale?(scale)
    [FAHRENHEIT, KELVIN, CELSIUS].include?(scale)
  end

  def self.input_temp_value
    puts 'Enter degree: '
    temperature = gets.chomp

    if temperature.match(Regexp.new(/\d(\.\d+)?/)).nil?
      puts 'Error: incorrect number format'
      return
    end

    next_state
    temperature.to_f
  end

  def self.input_scale(message)
    puts message
    start_scale = gets.chomp.upcase

    if valid_scale?(start_scale)
      next_state
      return start_scale
    end

    puts 'Incorrect scale'
  end

  def self.next_state
    @current_state = (@current_state + 1).modulo(IOStates.constants.count)
  end

  def self.start
    from_scale = CELSIUS
    to_scale = CELSIUS
    temp_value = 0

    loop do
      case @current_state
      when READ_FROM_TEMP_SCALE
        from_scale = input_scale('Enter scale you want to convert from (C, K, F): ')
      when READ_TO_TEMP_SCALE
        to_scale = input_scale('Enter result scale(C, K, F): ')
      when READ_FROM_TEMP_VALUE
        temp_value = input_temp_value
      when CONVERT_AND_EXIT
        result = ScaleConverter.convert(temp_value, from_scale, to_scale)
        puts "#{temp_value}°#{from_scale} = #{result}°#{to_scale}"
        exit
      end
    end
  end
end

IOManager.start
