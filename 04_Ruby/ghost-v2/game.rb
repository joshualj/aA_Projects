require_relative "player"

class Game

    attr_reader :current_player, :fragment, :losses, :players
    def initialize(*player_names)
        @players = []
        player_names.each {|player_name| @players << Player.new(player_name)}
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

    def display_standings(record)
        ghost = "GHOST"
        record.each do |k,v|
            letters = ghost[0...v]
            puts "#{k}'s Score: #{letters}"
        end
        return
    end

    def update_players         #not doing it's intended thang
        @players = @players.select {|player| @losses[player.name] < 5 }
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
                puts "_____________________"
                self.update_players
                return "#{@current_player.name} wins this round! The winning word is '#{@fragment}'."
            end
            self.next_player!
        end
    end

    def run
        until @players.count == 1 #@losses.keys.any? {|key| @losses[key] == 5}
            puts play_round
        end
        puts "#{@players[0].name} wins!!"
    end

end
