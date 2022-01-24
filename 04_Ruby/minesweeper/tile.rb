require_relative "board"

class Tile
    attr_reader :has_bomb, :position, :flagged, :revealed
    attr_accessor :neighboring_bombs_count

    def initialize(position, has_bomb)
        @has_bomb = has_bomb       #if has_bomb is true, this is a bomb square
        @position = position
        @flagged = false
        @revealed = false       #STILL NEED AN INSTANCE VARIABLE FOR THE BOARD?
        #@neighbors = []
        @neighboring_bombs_count = nil
    end


    # def neighboring_bombs_count
    #     neighbors_with_bomb = @neighbors.select {|tile| tile.has_bomb}
    #     return neighbors_with_bomb.count
    # end

    # def self.recursively_reveal_neighbors
    #     return false if neighboring_bombs_count != 0
    #     @neighbors.each {|neighbor| neighbor.reveal}
    #     @neighbors.each {|neighbor| neighbor.recursively_reveal_neighbors}
    # end

    def reveal      #ADD GAME OVER OPTION? (IF BOMB IS REVEALED)
        if !@revealed && !@flagged
            @revealed = true
        end

        return false if @has_bomb == true
        true
    end

    def toggle_flag
        @flagged ? @flagged = false : @flagged = true
    end

    def display
        return "F" if !@revealed && @flagged
        return "*" if !@revealed && !@flagged
        return "#{@neighboring_bombs_count}" if !@has_bomb
        return "B" if @has_bomb
    end
end
