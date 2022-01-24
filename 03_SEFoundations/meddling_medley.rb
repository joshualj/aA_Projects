require "byebug"

def duos(str)
    str.each_char.with_index.count {|ele, i| str[i] == str[i+1] if i + 1 < str.length}
end

# p duos('bootcamp')      # 1
# p duos('wxxyzz')        # 2
# p duos('hoooraay')      # 3
# p duos('dinosaurs')     # 0
# p duos('e')             # 0

def sentence_swap(sentence, hash)
    words = sentence.split
    new_words = []
    words.each do |word|
        if hash.keys.include?(word)
            new_words << hash[word]
        else
            new_words << word
        end
    end
    return new_words.join(" ")
end

# p sentence_swap('anything you can do I can do',
#     'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
# ) # 'nothing you shall drink I shall drink'

# p sentence_swap('what a sad ad',
#     'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
# ) # 'make a happy ad'

# p sentence_swap('keep coding okay',
#     'coding'=>'running', 'kay'=>'pen'
# ) # 'keep running okay'

def hash_mapped(hash, prc, &prc2)
    new_hash = Hash.new {|h, k| h[k] = 0}
    hash.keys.each {|key| new_hash[prc2.call(key)] = prc.call(hash[key])}
    new_hash
end

# double = Proc.new { |n| n * 2 }
# p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# # {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

# first = Proc.new { |a| a[0] }
# p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# # {25=>"q", 36=>"w"}

def counted_characters(str)
    character_counter = Hash.new{|h, k| h[k] = 0}
    str.each_char {|char| character_counter[char] += 1}
    return character_counter.keys.select {|key| character_counter[key] > 2}
end

# p counted_characters("that's alright folks") # ["t"]
# p counted_characters("mississippi") # ["i", "s"]
# p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
# p counted_characters("runtime") # []

def triplet_true(str)
    (0...str.length - 2).each do |idx|
        return true if str[idx] == str[idx + 1] && str[idx + 1] == str[idx + 2]
    end
    return false
end

# p triplet_true('caaabb')        # true
# p triplet_true('terrrrrible')   # true
# p triplet_true('runninggg')     # true
# p triplet_true('bootcamp')      # false
# p triplet_true('e')             # false

def energetic_encoding(str, hash)
    new_str = ""
    str.each_char do |char|
        if char == " "
            new_str += char
        elsif hash.keys.include?(char)
            new_str += hash[char]
        else
            new_str += '?'
        end
    end
    return new_str
end

# p energetic_encoding('sent sea',
#     'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
# ) # 'zimp ziu'

# p energetic_encoding('cat',
#     'a'=>'o', 'c'=>'k'
# ) # 'ko?'

# p energetic_encoding('hello world',
#     'o'=>'i', 'l'=>'r', 'e'=>'a'
# ) # '?arri ?i?r?'

# p energetic_encoding('bike', {}) # '????'

def uncompress(str)
    is_num = (0..9).to_a
    uncompressed_arr = []
    #debugger
    str.each_char.with_index do |char, i|
        if is_num.include?(char.to_i)
            char.to_i.times do
                uncompressed_arr << str[i -1]
            end
        end
    end
    return uncompressed_arr.join("")
end

# p uncompress('a2b4c1') # 'aabbbbc'
# p uncompress('b1o2t1') # 'boot'
# p uncompress('x3y1x2z4') # 'xxxyxxzzzz'

def conjunct_select(arr, *prcs)
    arr.select {|ele| prcs.all? {|prc| prc.call(ele)}}
end

is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def convert_pig_latin(sentence)
    words = sentence.split
    translated_sentence = []
    vowels = "aeiouAEIOU"
    words.each do |word|
        if word.length < 3
            translated_sentence << word
        else
            if vowels.include?(word[0])
                translated_sentence << word + "yay"
            else
                translated_sentence << pig_word(word).capitalize if word.capitalize == word
                translated_sentence << pig_word(word).downcase if word.downcase == word
            end
        end
    end
    return translated_sentence.join(" ")
end

def pig_word(word)
    vowels = "aeiouAEIOU"
    word.each_char.with_index do |char, i|
        if vowels.include?(char)
            return word[i...word.length] + word[0...i] + "ay"
        end
    end
end

# p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
# p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
# p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
# p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
# p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def reverberate(sentence)
    words = sentence.split
    vowels = "aeiouAEIOU"
    translated_sentence = []
    words.each do |word|
        if word.length < 3
            translated_sentence << word
        else
            if vowels.include?(word[-1])
                translated_sentence << word + word.downcase
            else
                translated_sentence << reverbed(word)
            end
        end
    end
    return translated_sentence.join(" ")
end

def reverbed(word)
    vowels = "aeiouAEIOU"
    iterator = word.length - 1
    new_word = ""
    #not_found = true
    while iterator >= 0
        if vowels.include?(word[iterator])
            return word + word[iterator...word.length].downcase
            #not_found = false
        end
        iterator -= 1
    end
end

p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *prcs)
    arr.select {|ele| prcs.any? {|prc| prc.call(ele)}}
end

# longer_four = Proc.new { |s| s.length > 4 }
# contains_o = Proc.new { |s| s.include?('o') }
# starts_a = Proc.new { |s| s[0] == 'a' }

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
# ) # ["apple", "teeming"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o
# ) # ["dog", "apple", "teeming", "boot"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o,
#     starts_a
# ) # ["ace", "dog", "apple", "teeming", "boot"]

def alternating_vowel(sentence)
    words = sentence.split
    new_sentence = []
    words.each.with_index do |word, idx|
        if (idx + 2) % 2 == 0
            new_sentence << first_vow_removed(word)
        else
            new_sentence << last_vow_removed(word)
        end
    end
    return new_sentence.join(" ")
end

def first_vow_removed(word)
    vowel = "aeiouAEIOU"
    word.each_char.with_index {|char, i| return word[0...i] + word[i + 1...word.length] if vowel.include?(char)}
end

def last_vow_removed(word)          #can just do first_vow_removed(word.reverse).reverse
    vowel = "aeiouAEIOU"
    iterator = word.length - 1
    vow_found = false
    while !vow_found
        return word[0...iterator] + word[iterator + 1...word.length] if vowel.include?(word[iterator])
        iterator -= 1
    end
end

# p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
# p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
# p alternating_vowel('code properly please') # "cde proprly plase"
# p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def silly_talk(sentence)
    words = sentence.split
    vowels = "aeiouAEIOU"
    translated_sentence = []
    words.each do |word|
        if vowels.include?(word[-1])
            translated_sentence << word + word[-1]
        else
            translated_sentence << sillified(word)
        end
    end
    return translated_sentence.join(" ")
end

def sillified(word)
    vowels = "aeiouAEIOU"
    new_word = ""
    word.each_char.with_index do |char, idx|
        if vowels.include?(char)
            new_word << char + "b" + char.downcase
        else
            new_word << char
        end
    end
    return new_word
end

# p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
# p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
# p silly_talk('They can code') # "Thebey caban codee"
# p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

def compress(str)       #clean up?
    streak = ""
    new_str = ""
    str.each_char.with_index do |char, idx|
        if str[idx] == str[idx - 1] || idx == 0
            streak << char
        else
            if streak.length == 1
                new_str << streak[0]
            else
                new_str << streak[0] + streak.length.to_s
            end
            streak = char
        end
    end
    new_str << streak[0]
    new_str << streak.length.to_s if streak.length > 1
    return new_str
end

# p compress('aabbbbc')   # "a2b4c"
# p compress('boot')      # "bo2t"
# p compress('xxxyxxzzzz')# "x3yx2z4"
