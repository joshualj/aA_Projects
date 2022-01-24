require_relative "item"

class List
    attr_reader :label  #can put :label as attr_accessor, then remove setter below
    #print styles (i.e. LINE_WIDTH = 49, INDEX_COL_WIDTH = 5) are set here in the solution, as constants

    def initialize(label)
        @label = label
        @items = []
    end

    def label=(new_label)
        @label = new_label
    end

    def add_item(title, deadline, description= "")
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
            return true
        else
            return false
        end
    end

    def size
        return @items.length
    end

    def valid_index?(index)
        return index >= 0 && index < @items.length
    end

    def swap(idx1, idx2)
        if self.valid_index?(idx1) && self.valid_index?(idx2)
            @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
            return true
        else
            return false
        end
    end

    def [](index)   #added top line after looking at solution
        return nil if !valid_index?(index)
        return @items[index]
    end

    def priority
        return @items[0]
    end

    def print       #solution has "puts '-' * LINE_WIDTH"
        item_title_sort = @items.sort_by {|item| item.title.length}
        longest_item = item_title_sort[-1].title
        #return longest_item
        longest_list_part = "#{"10".ljust("index".length + 1)} | #{longest_item.ljust(longest_item.length + 2)} | #{item_title_sort[-1].deadline.ljust(10)} | #{"Complete?".ljust(10)}".length
        puts @label.upcase.center(longest_list_part)
        puts "#{"Index".ljust("Index".length + 1)} | #{"Item".ljust(longest_item.length + 2)} | #{"Deadline".ljust(10)} | #{"Complete?".ljust(10)}"
        @items.each.with_index do |ele, idx|
            puts "#{idx.to_s.ljust("index".length + 1)} | #{ele.title.ljust(longest_item.length + 2)} | #{ele.deadline.ljust(10)} | #{ele.done.to_s.ljust(10)}"
        end
    end

    def print_full_item(index)
        return if @items[index].nil?    #added this line after looking @ solution
        if self.valid_index?(index)
            puts "#{@items[index].title}"
            puts "#{@items[index].deadline}"
            puts "#{@items[index].description}"
            puts "#{@items[index].done}"
        end
    end

    def print_priority
        #could have just put "print_full_item(0)"
        puts "#{@items[0].title}"
        puts "#{@items[0].deadline}"
        puts "#{@items[0].description}"
        puts "#{@items[index].done}"
    end

    def up(index, amount= 1)        #could have used a while loop --> while amount > 0 && index != 0 --> swap(index, index -1) --> index -= 1 --> index amount -= 1 --> end --> true
        if self.valid_index?(index)
            i = index
            if amount > index + 1
                turns = index
            else
                turns = amount
            end
            turns.times do
                @items[i], @items[i - 1] = @items[i - 1], @items[i]
                i -= 1
            end
            return true
        else
            return false
        end
    end

    def down(index, amount= 1)
        if self.valid_index?(index)
            i = index
            if amount + index > @items.length - 1
                turns = @items.length - 1 - index
            else
                turns = amount
            end
            turns.times do
                @items[i], @items[i + 1] = @items[i + 1], @items[i]
                i += 1
            end
            return true
        else
            return false
        end
    end

    def sort_by_date!
        @items.sort_by! {|item| item.deadline.to_s}
    end

    def toggle_item(index)      #solution had "if !@items[index].nil?", so I added it.
        @items[index].toggle if !@items[index].nil?
    end

    def remove_item(index)
        return false if index < 0 || index >= @items.length
        @items = @items[0...index] + @items[index + 1...@items.length]
        return true
    end

    def purge
        @items = @items.select {|item| item.done == false}
    end
end
