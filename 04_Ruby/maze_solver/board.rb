WIDTH = 16
HEIGHT = 8
WALL_PIECE = "*"
START_PIECE = "S"
END_PIECE = "E"
# board_shape = Array.new(8) {Array.new(16, " ")}
# (0...HEIGHT).each do |row|
#     (0...WIDTH).each do |col|
#         board_shape[row][col] = WALL_PIECE if row == 0 || row == HEIGHT - 1 || col == 0 || col == WIDTH - 1
#     end
# end
# (2...HEIGHT).each {|row| board_shape[row][6] = WALL_PIECE}
# (0..5).each {|row| board_shape[row][10] = WALL_PIECE}
# (13...WIDTH).each {|col| board_shape[2][col] = WALL_PIECE}
# board_shape[6][1] = START_PIECE
# board_shape[1][14] = END_PIECE
# BOARD_STRUCT = board_shape

class Board
    attr_reader :game_board, :start_position

    def initialize
        @game_board = Array.new(8) {Array.new(16, " ")}
        (0...HEIGHT).each do |row|
            (0...WIDTH).each do |col|
                @game_board[row][col] = WALL_PIECE if row == 0 || row == HEIGHT - 1 || col == 0 || col == WIDTH - 1
            end
        end
        (2...HEIGHT).each {|row| @game_board[row][6] = WALL_PIECE}
        (0..5).each {|row| @game_board[row][10] = WALL_PIECE}
        (13...WIDTH).each {|col| @game_board[2][col] = WALL_PIECE}
        @game_board[6][1] = START_PIECE
        @game_board[1][14] = END_PIECE
    end

    def [](pos)
        row, col = pos
        @game_board[row.to_i][col.to_i]
    end

    def []=(pos, val)
        row, col = pos
        @game_board[row][col] = val
    end

    def present
        @game_board.each {|row| print "#{row}\n"}
    end

    def return_position(piece)
        @game_board.each.with_index {|row, idx| row.each.with_index {|col, i| return [idx, i] if @game_board[idx][i] == piece}}
    end

    def start_position
        return_position(START_PIECE)
    end

    def end_position
        return_position(END_PIECE)
    end

    def empty_pos?(pos)
        self[pos] == ' ' || self[pos] == "E"
        #@game_board[pos[0]][pos[1]] == " "
    end

    def valid_pos?(pos)
        self[pos] == " " || self[pos] == "X" || self[pos] == "E"
        #@game_board[pos[0]][pos[1]] == " " || @game_board[pos[0]][pos[1]] == "X"
    end

    def wall_pos?(pos)
        self[pos] == "*"
    end

    def place_mark(pos)
        self[pos] = "X" if empty_pos?(pos)
        #@game_board[pos[0].to_i][pos[1].to_i] = "X" if empty_pos?(pos)
    end

    def empty_positions
        (0...@game_board.length).select do |row|
            row.each do |col|
                @game_board[row][col] == " "
            end
        end
    end


end
