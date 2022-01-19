require_relative "board"
require_relative "game"

class HumanPlayer

    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position(legal_positions)   #errors galore
        pos = nil
        until legal_positions.include?(pos)
            puts "Player #{@mark_value}, enter a numerical position in the format row column. (Type two numbers separated by one space): "
            entry = gets.chomp
            pos = entry.split(" ").map {|ele| ele.to_i}
            puts "#{pos} that is not a legal position" if !legal_positions.include?(pos)
            raise 'sorry, that was invalid :(' if pos.length != 2
        end


        # begin
        #     puts "Player #{@mark_value}, enter a numerical position in the format row column. (Type two numbers separated by one space): "
        #     entry = gets.chomp
        #     position = entry.split(" ").map {|ele| ele.to_i}
        #     nums = (0..9).to_a
        #     raise "error with entry" if entry.any? {|char| !nums.include?(char.to_i) && char != " "} || position.length != 2 || !nums.include?(position[0]) || !nums.include?(position[1])
        #     raise "error with entry, enter an empty space" if !legal_positions.include?(position)
        # rescue => e
        #     retry if e.message == "error with entry, enter an empty space" || e.message == "error with entry" || e.message == "not empty" || e.message == "not valid"
        # end

        pos
    end



        # print "Player #{@mark_value}, enter a numerical position in the format row column. (Type two numbers separated by one space): "
        # position = gets.chomp.split(" ").map {|ele| ele}
        # nums = (0..9).to_a
        # while !legal_positions.include?(position)
        #     raise "please only enter two numbers separated by one space" if position.any? {|char| !nums.include?(char) && char != " "}
        #     raise "please only enter two numbers separated by one space" if position.length != 3 || !nums.include?(new_arr[0].to_i) || new_arr[1] != " " || !nums.include?(new_arr[2])
        #     print "Player #{@mark_value}, enter a numerical position in the format row column. (Type two numbers separated by one space): "
        #     position = gets.chomp.split(" ").map {|ele| ele.to_i}
        # end
        # return position


        # new_arr = gets.chomp.split("")
        # nums = (0..9).to_a
        # raise "please only enter two numbers separated by one space" if new_arr.any? {|char| !nums.include?(char.to_i) && char != " "}
        # raise "please only enter two numbers separated by one space" if new_arr.length != 3 || !nums.include?(new_arr[0].to_i) || new_arr[1] != " " || !nums.include?(new_arr[2].to_i)
        # position = new_arr.join("").split(",").map! {|ele| ele.to_i}
        # raise "that position is not empty" if !legal_positions.include?(position)
        # begin
        #     get_position(legal_positions)
        # rescue

        # return position
        #return (new_arr.join("").split(",").map! {|ele| ele.to_i}).length
end
