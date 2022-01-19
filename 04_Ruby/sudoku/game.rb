require_relative 'board'
require_relative 'tile'
require 'byebug'

class Game
    def initialize
        @board = Board.new
    end

    def receive_position
        position = ""
        until @board.is_valid?(position)
            puts "insert a position in the format 2,2"
            position = gets.chomp.split(",")
            position.map! {|ele| ele.to_i}
        end
        position
    end

    def receive_val
        val = nil
        possibles = (1..9).to_a
        until possibles.include?(val)
            puts "insert a single digit value greater than 0"
            val = gets.chomp.to_i
        end
        val
    end

    def play
        until @board.solved?
            @board.render
            pos = receive_position
            val = receive_val.to_s  #need to convert to string
            @board.update_value(pos, val)
            @board.render
        end
        return "Congrats, you won!!!!"
    end

end
