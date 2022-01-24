require_relative "tile"
require 'yaml'
require 'byebug'

class Board
    attr_reader :grid

    def initialize
        @grid = Array.new(9) {Array.new(9, " ")}
        @game_over = false
        populate_board
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, val)
        row, col = pos
        @grid[row][col] = val
    end

    def populate_board            #This method populates the board one tile at time. Note: there is a 1 in 6 chance of a tile containing a bomb
        @grid.each.with_index do |row, i|
            row.each.with_index do |col, idx|
                random_number = rand(6)
                random_number == 5 ? @grid[i][idx] = Tile.new([i,idx], true) : @grid[i][idx] = Tile.new([i,idx], false)
            end
        end
    end

    def neighbors(tile)     #This method adds all tiles adjacent to 'tile' to an array, "neighborhood."
        neighborhood = []
        x_pos = tile.position[0]
        y_pos = tile.position[1]

        (x_pos - 1.. x_pos + 1).each do |i|         #set neighbors variable for each tile instance
            (y_pos - 1.. y_pos + 1).each do |idx|
                if i.between?(0, @grid.length - 1) && idx.between?(0, @grid.length - 1) && !(i == x_pos && idx == y_pos)
                    neighborhood << @grid[i][idx]
                end
            end
        end

        return neighborhood
    end

    def neighboring_bombs_count(tile)   #this method sets a tile's @neighboring_bombs_count variable then returns its value
        neighbors_with_bomb = neighbors(tile).select {|square| square.has_bomb}
        tile.neighboring_bombs_count = neighbors_with_bomb.count
        return neighbors_with_bomb.count
    end

    def recursively_reveal_neighbors(tile)          #ideally, this will recursively reveal all tiles adjacent to 'tile' if none contain a bomb
        return false if neighboring_bombs_count(tile) != 0

        neighbs = neighbors(tile).select {|neighbor| !neighbor.revealed && !neighbors(neighbor).all? {|ele| ele.revealed}}      #selects all neighbors that have have: 1.) not been revealed AND 2.) have unrevealed neighbors
        neighbs.each {|neighbor| neighbor.reveal}       #reveals all unrevealed neighbors
        neighbs.each {|neighbor| recursively_reveal_neighbors(neighbor)}    #recursively reveals neighbors who do not have a bomb adjacent to them
    end

    def render
        print "  "
        @grid.each.with_index {|row, idx| print "#{idx} "}
        print "\n"
        @grid.each.with_index do |row, i|
            line = row.map {|tile| tile.display}
            puts "#{i} #{line.join(" ")}"
        end
    end

    def get_instruction
        entry = nil

        until entry && valid_entry?(entry)
            #debugger
            puts "enter a command ('r' to reveal a tile, 'f' to flag a tile) AND a position (Example: r 4,4): "
            entry = gets.chomp
        end

        entry
    end

    def take_turn
        render
        command_pos = get_instruction       #receives a command and a position
        command = command_pos[0]
        pos = command_pos[-3..-1].split(",").map {|char| Integer(char)}

        if command == "f"
            @grid[pos[0]][pos[1]].toggle_flag      #toggle flag at pos if command is 'f'
        elsif command == "s"
            save
        else                            #if command is 'r', tile at pos will be revealed. If "false" is returned, it is a bomb. Thus, game_over = lose.
            if @grid[pos[0]][pos[1]].reveal == false
                @game_over = "lose"
            end

            if !@game_over          #if game not over, recursively reveal neighboring tiles
                recursively_reveal_neighbors(@grid[pos[0]][pos[1]]) #MAKE METHOD
            end
        end
    end

    def save
        puts "Enter filename to save at:"
        filename = gets.chomp

        File.write(filename, YAML.dump(self))
    end

    def check_won?
        sans_bomb = []          #sans_bomb contains instance variables of tile that do not have bombs

        @grid.each do |row|
            row.each {|tile| sans_bomb << tile unless tile.has_bomb}
        end

        @game_over = "win" if sans_bomb.all? {|tile| tile.revealed}
    end

    def valid_entry?(entry)
        return false if entry.length != 5

        command = entry[0]
        return false if command != "f" && command != "r" && command != "s"

        pos = entry[-3..-1].split(",").map {|char| Integer(char)}
        return false if pos.any? {|num| num < 0 || num >= @grid.length}

        return false if @grid[pos[0]][pos[1]].revealed || (command == "r" && @grid[pos[0]][pos[1]].flagged)

        true
    end

    def run
        until @game_over
            take_turn
            check_won?
        end

        render
        return "#{@game_over}"
    end

end


if $PROGRAM_NAME == __FILE__
    case ARGV.count
    when 0
        Board.new.run
    end
end
