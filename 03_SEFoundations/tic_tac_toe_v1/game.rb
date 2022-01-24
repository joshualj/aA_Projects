require_relative "board"
require_relative "human_player"

class Game
    attr_reader :player_1_mark, :player_2_mark, :current_player

    def initialize(player_1_mark, player_2_mark)
        @player_1 = HumanPlayer.new(player_1_mark)
        @player_2 = HumanPlayer.new(player_2_mark)
        @current_player = @player_1
        @board = Board.new
    end

    def switch_turn
        @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
    end

    def play
        while @board.empty_positions? #hmm
            @board.print
            @board.place_mark(@current_player.get_position, @current_player.mark_value)
            if @board.win?(@current_player.mark_value)
                return "Victory, player #{@current_player.mark_value} wins!"
            else
                self.switch_turn
            end
        end
        print "draw"
    end
end
