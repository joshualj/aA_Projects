require_relative "board"
require 'byebug'
PLAYER_PIECE = "X"

class Game
    attr_reader :current_position, :last_position
    def initialize
        @board = Board.new
        @current_position = @board.start_position
        @last_position = nil
        # @doorways = []
        # @board.game_board.each.with_index do |row, idx|
        #     row.each.with_index do |col, i|
        #         @doorways << [idx, i] if @board.game_board[idx - 1][i] == "*" && @board.game_board[idx + 1][i] == "*" && @board.game_board[idx][i] == " "
        #         @doorways << [idx, i] if @board.game_board[idx][i + 1] == "*" && @board.game_board[idx][i - 2] == "*" && @board.game_board[idx][i - 2] == " " && @board.game_board[idx][i - 2] == " "
        #     end
        # end
    end

    def [](pos)
        row, col = pos
        @current_position[row][col]
    end

    # def []=(pos, val)
    #     row, col = pos
    #     @game_board[row][col] = val
    # end

    def move(position)
        @last_position = @current_position
        @board.place_mark(position) if @board.valid_pos?(position)
        @current_position = position if @board.valid_pos?(position)
        @board.present
    end

    def available_moves   #creates hash of four orthogonal positions. Each key is a position. Each value is an array of size 2. Slot 1 of value is boolean indicating whether the position is valid(empty, has X, or is end_piece). Slot 2 of value is boolean indicating whether position is empty.
        options = Hash.new {|h, k| h[k] = []}
        left_position = [@current_position[0].to_i, (@current_position[1].to_i - 1).to_i]
        right_position = [@current_position[0].to_i, (@current_position[1].to_i + 1).to_i]
        up_position = [(@current_position[0].to_i - 1).to_i, @current_position[1].to_i]
        down_position = [(@current_position[0].to_i + 1).to_i, @current_position[1].to_i]
        options[up_position] << @board.valid_pos?(up_position)
        options[up_position] << @board.empty_pos?(up_position)
        options[down_position] << @board.valid_pos?(down_position)
        options[down_position] << @board.empty_pos?(down_position)
        options[left_position] << @board.valid_pos?(left_position)
        options[left_position] << @board.empty_pos?(left_position)
        options[right_position] << @board.valid_pos?(right_position)
        options[right_position] << @board.empty_pos?(right_position)
        return options.select {|k,v| v[0] == true}.to_h
    end

    def is_toward_goal?(proposition, goal_position)
        current_goal_x = (@current_position[0] - goal_position[0]).abs
        current_goal_y = (@current_position[1] - goal_position[1]).abs
        current_goal_dist = Math.sqrt((current_goal_x * current_goal_x) + (current_goal_y * current_goal_y))
        prop_goal_x = (proposition[0] - goal_position[0]).abs
        prop_goal_y = (proposition[1] - goal_position[1]).abs
        prop_goal_dist = Math.sqrt((prop_goal_x * prop_goal_x) + (prop_goal_y * prop_goal_y))
        return current_goal_dist > prop_goal_dist
    end

    def winning_move?(positions)    #returns array with winning position if winning position is adjacent. else, returns empty array
        positions.keys.select {|pos| pos == @board.end_position}
    end

    def can_move_forward?
        return @board.empty_pos?(forward_position)
        # return !@board.wall_pos?([@current_position[0].to_i - 1, @current_position[1]]) if current_direction == "up"
        # return !@board.wall_pos?([@current_position[0].to_i + 1, @current_position[1]]) if current_direction == "down"
        # return !@board.wall_pos?([@current_position[0].to_i, @current_position[1] - 1]) if current_direction == "left"
        # return !@board.wall_pos?([@current_position[0].to_i, @current_position[1] + 1]) if current_direction == "right"
    end

    def forward_position
        return [@current_position[0].to_i - 1, @current_position[1]] if current_direction == "up"
        return [@current_position[0].to_i + 1, @current_position[1]] if current_direction == "down"
        return [@current_position[0].to_i, @current_position[1] - 1] if current_direction == "left"
        return [@current_position[0].to_i, @current_position[1] + 1] if current_direction == "right"
    end

    def change_direction    #now need to have it so it moves towards the end_goal
        new_options = available_moves.keys.select {|key| key != @last_position}
        empty_new_options = new_options.select {|option| @board.empty_pos?(option)}
        empty_toward_goal_options = empty_new_options.select {|pos| is_toward_goal?(pos, @board.end_position)}
        if !empty_toward_goal_options.empty?
            move(empty_toward_goal_options.sample)
        elsif !empty_new_options.empty? && empty_new_options.include?(forward_position)
            move(forward_position)
        elsif !empty_new_options.empty? && !empty_new_options.include?(forward_position)
            move(empty_new_options.sample)
        else
            move(@last_position)
        end
    end

    def current_direction
        up_down = (@current_position[0] - @last_position[0])
        left_right = (@current_position[1] - @last_position[1])
        return "up" if up_down < 0
        return "down" if up_down > 0
        return "left" if left_right < 0
        return "right" if left_right > 0
    end

    def won?
        return available_moves.include?(@board.end_position)
    end

    def run
        until self.won?
            #debugger

            if @last_position == nil #|| !can_move_forward?
                change_direction
                #return "wow you won" if won?
            elsif can_move_forward?
                puts (can_move_forward?)
                move(forward_position)
                return "NICE" if won?
            else
                puts (can_move_forward?)
                change_direction
                return "NICE" if won?
            end
        end
        return "YAYYY YOU WON"
    end
end
