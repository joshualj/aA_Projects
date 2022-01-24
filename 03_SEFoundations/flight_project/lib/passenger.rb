require "flight"

class Passenger
    def initialize(name)
        @name = name
        @flight_numbers = []
    end

    def name
        @name
    end

    def has_flight?(str)
        return @flight_numbers.include?(str.upcase)
    end

    def add_flight(flight)
        @flight_numbers << flight.upcase if !has_flight?(flight.upcase)
    end

end
