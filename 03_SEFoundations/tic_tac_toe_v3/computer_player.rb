require_relative "board"    #don't need
require_relative "game"     #don't need

class ComputerPlayer
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
        #@legal_positions = Board.legal_positions    #unsure about this line
    end

    def get_position(legal_positions)
        pos = legal_positions.sample
        puts "Computer #{@mark_value} chose position #{pos}"
        return pos
    end
end
