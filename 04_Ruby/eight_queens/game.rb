require_relative "board"
require 'byebug'

class Game
    def initialize(n)
        @n = n
        @board = Board.new(n)
    end

    def lists
        odd = []
        even = []
        (1..@n).each {|i| i.even? ? even << i : odd << i}
        if @n % 6 == 2
            odd[0], odd[1] = odd[1], odd[0]
            odd << odd[2]
            odd = odd[0...2] + odd[3..-1]
        end
        if @n % 6 == 3
            even << even[0]
            even = even[1..-1]
            odd << odd[0]
            odd << odd[1]
            odd = odd[2..-1]
        end
        return even + odd
    end

    # def [](pos)
    #     row, col = pos
    #     self[row][col]
    # end

    def place_queens
        #debugger
        rows = lists
        print "#{rows}\n"
        (0...@n).each do |col|
            # puts rows[col]
            # puts col
            @board.place_queen([@n - rows[col], col])
        end
        @board.present
    end


    def multiples_of_3_or_5
        multiples_of_3 = []
        multiples_of_5 = []
        (1...1000).each do |num|
            multiples_of_3 << num if num % 3 == 0
            multiples_of_5 << num if num % 5 == 0 if num % 3 != 0
        end
        return multiples_of_3.sum + multiples_of_5.sum
    end

    def fibonacci(n)
        return [1] if n == 1
        return [1,2] if n == 2
        fibonacci(n-1) << fibonacci(n-1).pop + fibonacci(n-2).pop
    end

    def even_fibonacci(n)
        fibonacci(n).select {|ele| ele.even? && ele < 4000000}#.sum
    end


end
