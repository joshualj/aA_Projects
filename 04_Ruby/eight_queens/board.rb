
class Board
    def initialize(side)
        @grid = Array.new(side) {Array.new(side, " ")}
    end

    def present
        @grid.each {|row| print "#{row}\n" }
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, val)
        row, col = pos
        @grid[row][col] = val
    end

    def place_queen(pos)
        self[pos] = "Q"
    end
end
