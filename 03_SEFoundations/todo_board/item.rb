
class Item
    attr_reader :title, :deadline, :description, :done
    #should have :title and :description as attr_accessor options, not attr_reader. Then you can remove their respective getter/setter methods below

    def self.valid_date?(date_string)
        year_month_day = date_string.split("-") #originally forgot to insert length (year_month_day.length == 3)
        return year_month_day[0].length == 4 && year_month_day.length == 3 && year_month_day[1].to_i >= 0 && year_month_day[1].to_i <= 12 && year_month_day[2].to_i > 0 && year_month_day[2].to_i <= 31
    end

    def initialize(title, deadline, description)    #originally did not raise error in first line. It was the second
        raise "invalid deadline" if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    def title=(new_title)   #not needed since you have it as a reader
        @title = new_title
    end

    def deadline=(new_deadline)
        raise "invalid deadline" if !Item.valid_date?(new_deadline)
        @deadline = new_deadline
    end

    def description=(new_description)
        @description = new_description
    end

    def toggle
        @done == true ? @done = false : @done = true
    end

end

# p Item.valid_date?('2019-10-25') # true
# p Item.valid_date?('1912-06-23') # true
# p Item.valid_date?('2018-13-20') # false
# p Item.valid_date?('2018-12-32') # false
# p Item.valid_date?('10-25-2019') # false

# p Item.new('Fix login page', '2019-10-25', 'The page loads too slow.')

# p Item.new(
#     'Buy Cheese',
#     '2019-10-21',
#     'We require American, Swiss, Feta, and Mozzarella cheese for the Happy hour!'
# )

# p Item.new(
#     'Fix checkout page',
#     '10-25-2019',
#     'The font is too small.'
# ) # raises error due to invalid date
