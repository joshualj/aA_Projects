require_relative "list"
require_relative "item"

class TodoBoard
    def initialize        #don't need any parameters
        @hash = {}
    end

    def get_command         #don't need to put return true after all of these. Can just have it at the end
        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(" ")  #should put target in between cmd, args. Then can simplify all below "when lines" to one-line

        case cmd
        when 'mklist'
            @hash[args[0].to_s] = List.new(args[0].to_s)
            return true
        when 'ls'
            @hash.keys.each {|list_label| puts list_label}
            return true
        when 'showall'
            @hash.values.each {|list_instance| list_instance.print}
        when 'mktodo'
            if args[3] == nil
                @hash[args[0].to_s].add_item(args[1], args[2])
            else
                @hash[args[0].to_s].add_item(args[1], args[2], args[3])
            end
            return true
        when 'quit'
            return false
        when 'up'
            if args[2] == nil
                @hash[args[0].to_s].up(args[1].to_i)
            else
                @hash[args[0].to_s].up(args[1].to_i, args[2].to_i)
            end
            return true
        when 'down'
            if args[2] == nil
                @hash[args[0].to_s].down(args[1].to_i)
            else
                @hash[args[0].to_s].down(args[1].to_i, args[2].to_i)
            end
            return true
        when 'swap'
            @hash[args[0].to_s].swap(args[1].to_i, args[2].to_i)
            return true
        when 'sort'
            @hash[args[0].to_s].sort_by_date!
            return true
        when 'priority'
            @hash[args[0].to_s].print_priority
            return true
        when 'print'
            if args[1] == nil
                @hash[args[0].to_s].print
                return true
            else
                @hash[args[0].to_s].print_full_item(args[1].to_i)
                return true
            end
        when 'toggle'
            @hash[args[0].to_s].toggle_item(args[1].to_i)  ##***
            return true
        when 'rm'
            @hash[args[0].to_s].remove_item(args[1].to_i)
            return true
        when 'purge'
            @hash[args[0].to_s].purge
            return true
        else
            print "Sorry, that command is not recognized."
        end

        true
    end

    def run
        self.get_command until self.get_command == false
    end


end

p my_board = TodoBoard.new
my_board.run
#can just have TodoBoard.new.run
