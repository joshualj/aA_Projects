require_relative "player"

class Game

    attr_reader :current_player, :fragment, :losses
    def initialize(*player_marks)
        @players = []
        @player_marks = player_marks
        @player_marks.each {|player_mark| @players << Player.new(player_mark)}
        @fragment = ""
        @dictionary = {}
        file = File.open("dictionary.txt")
        file.each do |line|
            word = line.chomp
            @dictionary[word] = 0
        end
        @current_player = @players[0]
        @losses = {}
        @players.each {|player| @losses[player.name] = 0}
    end

    def previous_player
        @players[(@players.index(@current_player) - 1) % @players.length]
    end

    def next_player!
        @current_player = @players[(@players.index(@current_player) + 1) % @players.length]
    end

    def starts_with?(word, string)
        (0...string.length).all? {|num| word[num] == string[num]}
    end

    def valid_play?(string)
        letters = ("a".."z").to_a
        possible_word = @fragment.to_s + string.to_s
        return letters.include?(string) && @dictionary.keys.any? {|word| starts_with?(word, possible_word)}
    end

    def win?(string)
        return @dictionary[string] == 0
    end

    def take_turn(player)
        entry = ""
        until valid_play?(entry)
            puts "#{player.name}, please enter a lowercase letter: "
            entry = gets.chomp
            puts "please try again" if !valid_play?(entry)
        end
        @fragment << entry
        return @fragment
        #return true #should I include this line?
    end


    def play_round
        @fragment = ""
        display_standings(@losses)
        until win?(@fragment)   #should I just do until win?(take_turn(player))?
            puts "_____________________"
            puts "fragment thus far: '#{@fragment}'"
            take_turn(@current_player)
            if win?(@fragment)
                @losses.keys.each {|key| @losses[key] += 1 if key != @current_player.name}
                return "#{@current_player.name} wins this round! The winning word is '#{@fragment}'."
            end
            self.next_player!
        end
    end

    def display_standings(record)
        ghost = "GHOST"
        record.each do |k,v|
            letters = ghost[0...v]
            puts "#{k}'s Score: #{letters}"
        end
        return
    end

    def run
        until @losses.keys.any? {|key| @losses[key] == 5}
            puts play_round
        end
    end




end

p Game.new("Sally", "Josh")
