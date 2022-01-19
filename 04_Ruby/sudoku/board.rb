require_relative 'tile'
require 'byebug'
#require_relative './puzzles/sudoku1.txt'

class Board
    def initialize
        @game_board = Array.new(9) {Array.new(9, ' ')}
        file = File.open("puzzles/sudoku1_almost.txt")
        file.each.with_index do |vals, idx|
            line = vals.chomp
            line.each_char.with_index do |val, i|
                @game_board[idx][i] = Tile.new(val)
            end
        end
    end

    def [](pos)
        row, col = pos
        @game_board[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @game_board[row][col] = value
    end

    def update_value(position, value)
        row, col = position
        @game_board[row][col].change_value(value)
    end

    def render
        @game_board.each do |row|
            print "\n"
            row.each {|tile| print tile.to_s}
        end
        print "\n"
    end

    def has_all_nine_once?(array)
        ("1".."9").each {|num| return false if array.count(num) != 1}
        return true
    end

    def col_vals(column)
        @game_board.map.with_index {|row, i| @game_board[i][column].value.to_s}
    end

    def row_vals(row)
        @game_board.map.with_index {|col, i| @game_board[row][i].value.to_s}
    end

    def three_x_three_vals(big_tile)    #big_tile refers to a 3x3 section of individual tiles. A sudoku board has three big_tiles. 0-8
        starting_point = [0,0] if big_tile == 0
        starting_point = [0,3] if big_tile == 1
        starting_point = [0,6] if big_tile == 2
        starting_point = [3,0] if big_tile == 3
        starting_point = [3,3] if big_tile == 4
        starting_point = [3,6] if big_tile == 5
        starting_point = [6,0] if big_tile == 6
        starting_point = [6,3] if big_tile == 7
        starting_point = [6,6] if big_tile == 8

        array = []
        (starting_point[0]...starting_point[0] + 3).each do |row|
            (starting_point[1]...starting_point[1] + 3).each do |col|
                array << @game_board[row][col].value
            end
        end
        return array
    end

    def solved?
        (0..8).all? {|num| has_all_nine_once?(col_vals(num)) && has_all_nine_once?(row_vals(num)) && has_all_nine_once?(three_x_three_vals(num))}
    end

    def is_valid?(pos)
        return false if pos.length != 2
        row, col = pos
        return false if row > @game_board.length - 1 || row < 0 || col < 0 || col > @game_board.length - 1
        return !@game_board[row][col].given
    end
end
