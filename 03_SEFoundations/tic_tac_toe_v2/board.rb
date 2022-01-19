require 'byebug'
require_relative "game"
require_relative "human_player"

class Board

    attr_reader :grid
    def initialize(n)
        @grid = Array.new(n) {Array.new(n, '_')}
    end

    def valid?(position)
        return (position[0] < @grid.length && position[0] >= 0 && position[1] >= 0 && position[1] < @grid.length)
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
        return @grid.any? {|row| row.all? {|char| char == mark}}
    end

    def win_col?(mark)
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

end
