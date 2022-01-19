require 'byebug'
require_relative "game"
require_relative "human_player"
require_relative "computer_player"

class Board
    attr_reader :grid #not a thing in the solution
    def initialize(n)
        @grid = Array.new(n) {Array.new(n, '_')}
    end

    def valid?(position)
        return (position[0] < @grid.length && position[0] >= 0 && position[1] >= 0 && position[1] < @grid.length)   #again, can have row, col = pos as first line, then for next lines can just do pos.all? greater than or equal to 0 and less than @grid.length
    end

    def empty?(position)
        return @grid[position[0]][position[1]] == "_"
    end

    def place_mark(position, mark)
        raise "not valid" if !valid?(position)
        raise "not empty" if !empty?(position)
        @grid[position[0]][position[1]] = mark
    end

    def print
        @grid.each do |row|
            p row
        end
    end

    def win_row?(mark)
        return @grid.any? {|row| row.all? {|char| char == mark}}    #can just write: @grid.any? {|row| row.all?(mark)}
    end

    def win_col?(mark)      #can write: @grid.transpose.any? { |col| col.all?(mark) }
        (0...@grid.length).any? {|column| (0...@grid.length).all? {|row| @grid[row][column] == mark}}
    end

    def win_diagonal?(mark)
        @grid.each.with_index.all? {|row, idx| row[idx] == mark} || @grid.each.with_index.all? {|row, idx| row[@grid.length - 1 - idx] == mark}
    end

    def win?(mark)
        return self.win_row?(mark) || self.win_col?(mark) || self.win_diagonal?(mark)
    end

    def empty_positions?
        @grid.any? {|row| row.include?("_")}
    end

    def legal_positions
        new_arr = []
        (0...@grid.length).each do |row|
            (0...@grid.length).each do |position|
                new_arr << [row] + [position] if self.empty?([row] + [position])
            end
        end
        return new_arr
    end
end
