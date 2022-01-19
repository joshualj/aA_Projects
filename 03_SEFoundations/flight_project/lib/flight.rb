require "passenger"

class Flight
    attr_reader :passengers

    def initialize(flight_number, capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end

    def full?
        return @capacity <= @passengers.count
    end

    def board_passenger(passenger)
        @passengers << passenger if passenger.has_flight?(@flight_number) && !self.full?
    end

    def list_passengers
        names = @passengers.map {|passenger| passenger.name}
        return names
    end

    def [](idx)
        return @passengers[idx]
    end

    def <<(passenger_inst)
        self.board_passenger(passenger_inst)
    end
end
