require 'set'
require 'byebug'

class WordChainer
    attr_reader :dict

    def initialize(dictionary_file_name)
        file = (File.open(dictionary_file_name))
        @dict = Set.new()
        file.each do |line|
            word = line.chomp
            @dict.add(word)
        end
    end

    def adjacent_words(word)
        adj_words = dict.select do |ele|
            word.length == ele.length &&
            (0...word.length).one? {|idx| word[idx] != ele[idx]}
        end
        return adj_words
    end

    def run(source, target)
        @current_words = [source]
        @all_seen_words = {source => nil}
        until @current_words.empty? || @all_seen_words.include?(target)
            explore_current_words
        end
        build_path(target)
    end

    def explore_current_words #(current_words)
        new_words = []
        @current_words.each do |current_word|
            adj = adjacent_words(current_word)
            adj.each do |adjacent_word|
                if !@all_seen_words.has_key?(adjacent_word)
                    new_words << adjacent_word
                    @all_seen_words[adjacent_word] = current_word
                end
            end
        end
        @current_words = new_words
        new_words.each {|word| print "#{word} => #{@all_seen_words[word]} \n"}
        return new_words
    end

    def build_path(target)
        path = [target]
        until path.last == nil
            path << @all_seen_words[path.last]
        end
        return path[0...-1].reverse
    end
end
