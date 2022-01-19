require_relative "board"
require_relative "game"

class HumanPlayer

    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position
        print "Player #{@mark_value}, enter a numerical position in the format row,column. Include a comma and do not use any spaces: "
        new_arr = gets.chomp.split("")
        nums = (0..9).to_a
        raise "please only enter two numbers separated by one comma" if new_arr.any? {|char| !nums.include?(char.to_i) && char != ","}
        raise "please only enter two numbers separated by one comma" if new_arr.length != 3 || !nums.include?(new_arr[0].to_i) || new_arr[1] != "," || !nums.include?(new_arr[2].to_i)
        return new_arr.join("").split(",").map! {|ele| ele.to_i}
        #return (new_arr.join("").split(",").map! {|ele| ele.to_i}).length
    end
end
