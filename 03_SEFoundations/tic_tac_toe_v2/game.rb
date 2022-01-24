require_relative "board"
require_relative "human_player"

class Game
    attr_reader :players, :current_player, :board
    def initialize(board_size, *player_marks)
        @players_count = player_marks.count
        @players = player_marks.map {|mark| HumanPlayer.new(mark)} #this line wasn't working when using each.
        @current_player = @players[0]
        @board = Board.new(board_size)
    end

    def switch_turn
        @current_player = @players[(@players.index(@current_player) + 1) % (@players.length)]
    end

    def play
        while @board.empty_positions? #hmm
            #@board.print
            @board.place_mark(@current_player.get_position, @current_player.mark_value)
            @board.print
            if @board.win?(@current_player.mark_value)
                return "Victory, player #{@current_player.mark_value} wins!"
            else
                self.switch_turn
            end
        end
        return "draw"
    end
end
