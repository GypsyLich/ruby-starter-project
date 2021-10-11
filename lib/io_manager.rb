require_relative './enums/io_states'
require_relative './enums/temp_scale_names'
require_relative './scale_converter'

class IOManager
  include IOStates
  include TempScaleNames

  @current_state = READ_FROM_TEMP_SCALE

  def initialize
    @current_state = READ_FROM_TEMP_SCALE
  end

  def valid_scale?(scale)
    [FAHRENHEIT, KELVIN, CELSIUS].include?(scale)
  end

  def input_temp_value
    puts 'Enter degree: '
    temperature = gets
    temperature ||= ''
    temperature.chomp!

    if temperature.match(Regexp.new(/\d(\.\d+)?/)).nil?
      puts 'Error: incorrect number format'
      return
    end

    next_state
    temperature.to_f
  end

  def input_scale(message)
    puts message
    start_scale = gets
    start_scale ||= ''
    start_scale = start_scale.upcase
    start_scale.chomp!

    if valid_scale?(start_scale)
      next_state
      return start_scale
    end

    puts 'Incorrect scale'
  end

  def next_state
    @current_state = (@current_state + 1).modulo(IOStates.constants.count)
  end

  def start
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
        result = ScaleConverter.new.convert(temp_value, from_scale, to_scale)
        puts "#{temp_value}°#{from_scale} = #{result}°#{to_scale}"
        exit
      end
    end
  end
end

io = IOManager.new
io.start
