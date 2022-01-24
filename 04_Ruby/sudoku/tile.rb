require 'colorized_string'
require 'colorize'

class Tile
    attr_reader :to_s, :value, :given
    def initialize(value)
        @value = value
        value == "0" ? @given = false : @given = true
    end

    def to_s
        return @value.colorize(:yellow) if @given
        return @value
    end

    def change_value(new_val)
        unless @given
            @value = new_val
            return true
        end
        puts "Sorry, this value was given and cannot be changed."
        return false
    end
end
