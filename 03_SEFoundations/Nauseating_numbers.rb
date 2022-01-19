require 'byebug'

def strange_sums(arr)
    count = 0
    (0...arr.length - 1).each do |num|
        (num + 1...arr.length).each {|num2| count += 1 if arr[num] + arr[num2] == 0}
    end
    return count
end

# p strange_sums([2, -3, 3, 4, -2])     # 2
# p strange_sums([42, 3, -1, -42])      # 1
# p strange_sums([-5, 5])               # 1
# p strange_sums([19, 6, -3, -20])      # 0
# p strange_sums([9])                   # 0

def pair_product(num_arr, prod)
    (0...num_arr.length - 1).each do |num|
        (num + 1...num_arr.length).each {|num2| return true if num_arr[num] * num_arr[num2] == prod}
    end
    return false
end

# p pair_product([4, 2, 5, 8], 16)    # true
# p pair_product([8, 1, 9, 3], 8)     # true
# p pair_product([3, 4], 12)          # true
# p pair_product([3, 4, 6, 2, 5], 12) # true
# p pair_product([4, 2, 5, 7], 16)    # false
# p pair_product([8, 4, 9, 3], 8)     # false
# p pair_product([3], 12)             # false


def rampant_repeats(str, hash)
    new_str = ""
    str.each_char do |char|
        if hash.keys.include?(char)
            hash[char].times do
                new_str << char
            end
        else
            new_str << char
        end
    end
    return new_str
end

# p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
# p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
# p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
# p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'

def perfect_square(num)
    (1..num).any? {|poss_square| poss_square * poss_square == num}
end

# p perfect_square(1)     # true
# p perfect_square(4)     # true
# p perfect_square(64)    # true
# p perfect_square(100)   # true
# p perfect_square(169)   # true
# p perfect_square(2)     # false
# p perfect_square(40)    # false
# p perfect_square(32)    # false
# p perfect_square(50)    # false

def anti_prime?(num)
    og_divisors = 0
    max_div_div = 0
    (1...num).each do |divisor|
        og_divisors += 1 if num % divisor == 0
        current_div_div = 0
        (1...divisor).each do |div_div|
            current_div_div += 1 if divisor % div_div == 0
        end
        max_div_div = current_div_div if current_div_div > max_div_div
    end
    return og_divisors > max_div_div
end

# p anti_prime?(24)   # true
# p anti_prime?(36)   # true
# p anti_prime?(48)   # true
# p anti_prime?(360)  # true
# p anti_prime?(1260) # true
# p anti_prime?(27)   # false
# p anti_prime?(5)    # false
# p anti_prime?(100)  # false
# p anti_prime?(136)  # false
# p anti_prime?(1024) # false

def matrix_addition(mat, mat2)
    new_mat = Array.new(mat.length) {Array.new(mat[0].length)}
    mat.each.with_index do |array, i|
        array.each.with_index do |subarray, idx|
            new_mat[i][idx] = mat[i][idx] + mat2[i][idx]
        end
    end
    return new_mat
end

matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
# p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
# p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
# p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]

def mutual_factors(*nums)
    factor_tracker = Hash.new {|h,k| h[k] = []}
    nums.each do |num|
        (1..num).each do |possible_facts|
            factor_tracker[num] << possible_facts if num % possible_facts == 0
        end
    end
    #keys = factor_tracker.keys
    values = factor_tracker.values.flatten
    value_tracker = Hash.new {|h,k| h[k] = 0}
    values.each {|val| value_tracker[val] += 1}
    return value_tracker.keys.select {|key| value_tracker[key] == nums.length}

end

# p mutual_factors(50, 30)            # [1, 2, 5, 10]
# p mutual_factors(50, 30, 45, 105)   # [1, 5]
# p mutual_factors(8, 4)              # [1, 2, 4]
# p mutual_factors(8, 4, 10)          # [1, 2]
# p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
# p mutual_factors(12, 24, 64)        # [1, 2, 4]
# p mutual_factors(22, 44)            # [1, 2, 11, 22]
# p mutual_factors(22, 44, 11)        # [1, 11]
# p mutual_factors(7)                 # [1, 7]
# p mutual_factors(7, 9)              # [1]

def tribonacci_number(n)
    return 1 if n == 1 || n==2
    return 2 if n == 3
    tribonacci_number(n - 1) + tribonacci_number(n-2) + tribonacci_number(n-3)
end

# p tribonacci_number(1)  # 1
# p tribonacci_number(2)  # 1
# p tribonacci_number(3)  # 2
# p tribonacci_number(4)  # 4
# p tribonacci_number(5)  # 7
# p tribonacci_number(6)  # 13
# p tribonacci_number(7)  # 24
# p tribonacci_number(11) # 274

def matrix_addition_reloaded(*mats)
    return nil if !mats.all? {|matrix| matrix.length == mats[0].length}
    mats.each do |matrix|
        matrix.each.with_index do |array, idx|
            return nil if !mats.all? {|matrix| matrix[idx].length == array.length}
        end
    end

    new_mat = Array.new(mats[0].length) {Array.new(mats[0][1].length, 0)}
    mats.each do |matrix|
        matrix.each.with_index do |array, i|
            array.each.with_index do |subarray, idx|
                new_mat[i][idx] += matrix[i][idx]
            end
        end
    end
    return new_mat
end


matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
# p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
# p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
# p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil

def squarocol?(matrix)
    horizontal_check = Array.new(matrix[0].length) {|ele| 0}
    vertical_check = Array.new(matrix[0].length) {|ele2| 0}
    matrix.each do |array|
        return true if array.all? {|ele| ele == array[0]}
        array.each_index {|i| return true if matrix.all? {|arr| arr[i] == array[i]}}
    end
    return false
end

# p squarocol?([
#     [:a, :x , :d],
#     [:b, :x , :e],
#     [:c, :x , :f],
# ]) # true

# p squarocol?([
#     [:x, :y, :x],
#     [:x, :z, :x],
#     [:o, :o, :o],
# ]) # true

# p squarocol?([
#     [:o, :x , :o],
#     [:x, :o , :x],
#     [:o, :x , :o],
# ]) # false

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 7],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # true

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 0],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # false


def squaragonal?(arr2)
    top_left = []
    top_right = []
    arr2.each.with_index {|subarr, i| top_left << subarr[i]}
    arr2.each.with_index {|subarr, i| top_right << subarr[subarr.length - 1 - i]}
    return top_left.all? {|ele| ele == top_left[0]} || top_right.all? {|ele| ele == top_right[0]}
end

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :x, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :o, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 7],
#     [1, 1, 6, 7],
#     [0, 5, 1, 7],
#     [4, 2, 9, 1],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 5],
#     [1, 6, 5, 0],
#     [0, 2, 2, 7],
#     [5, 2, 9, 7],
# ]) # false

def pascals_triangle(num= 0)
    return 0 if num == 0
    return [[1]] if num == 1
    past = pascals_triangle(num - 1)[-1]
    arr = []
    past.each.with_index do |numb, i|
        if i == 0
            arr << past[i]
        end
        if i + 1 < past.length
            arr << past[i] + past[i + 1]
        end
        if i == past.length - 1
            arr << past[i]
        end
    end
    pascals_triangle(num-1) << arr
end
        # if i == 0
        #     pascals_triangle(num-1) << 1
        # end
        # if pascals_triangle(num-1).length > 1
        #     pascals_triangle(num-1) <<
        # if i == pascals_triangle(num-1).length - 1
        #     pascals_triangle(num-1) << 1
        # end

# p pascals_triangle(5)
# # [
# #     [1],
# #     [1, 1],
# #     [1, 2, 1],
# #     [1, 3, 3, 1],
# #     [1, 4, 6, 4, 1]
# # ]

# p pascals_triangle(7)
# # [
# #     [1],
# #     [1, 1],
# #     [1, 2, 1],
# #     [1, 3, 3, 1],
# #     [1, 4, 6, 4, 1]
# # ]


def mersenne_prime(n)
    arr = []
    i = 2
    while arr.length < n
        arr << i if is_prime?(i) && is_power_two(i + 1)
        i += 1
    end
    return arr[-1]
end

def is_power_two(num)
    j = 1
    while j <= num
        return true if j == num
        j *= 2
    end
    return false
end

def is_prime?(num)
    return false if num < 2

    (2...num).each do |ele|
        return false if num % ele == 0
    end
    return true
end

# p mersenne_prime(1) # 3
# p mersenne_prime(2) # 7
# p mersenne_prime(3) # 31
# p mersenne_prime(4) # 127
# p mersenne_prime(6) # 131071

def triangular_word?(word)
    alpha = ('a'..'z').to_a
    word_score = 0
    word.each_char {|char| word_score += alpha.index(char) + 1}
    return is_triangular_number?(word_score)
end

def is_triangular_number?(num)
    i = 1
    j = (i * (i + 1)) / 2
    while j <= num
        return true if j == num
        i += 1
        j = (i * (i + 1)) / 2
    end
    return false
end

# p triangular_word?('abc')       # true
# p triangular_word?('ba')        # true
# p triangular_word?('lovely')    # true
# p triangular_word?('question')  # true
# p triangular_word?('aa')        # false
# p triangular_word?('cd')        # false
# p triangular_word?('cat')       # false
# p triangular_word?('sink')      # false

def consecutive_collapse(arr)
    i = 0
    j = 1
    new_arr = arr
    removed = false
    #debugger
    while j < arr.length && removed == false
        if are_consecutive?(arr[i], arr[j])
            new_arr = new_arr[0...i] + new_arr[j + 1...new_arr.length] if j + 1 < new_arr.length
            new_arr = new_arr[0...i] if j + 1 == new_arr.length
            removed = true
        end
        #return new_arr if j == arr.length - 1
        i += 1
        j += 1
    end
    if new_arr == arr
        return new_arr
    else
        consecutive_collapse(new_arr)
    end
end

def are_consecutive?(num1, num2)
    return true if num1 - num2 == 1 || num2 - num1 == 1
    return false
end

# p consecutive_collapse([3, 4, 1])                     # [1]
# p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
# p consecutive_collapse([9, 8, 2])                     # [2]
# p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
# p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
# p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
# p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
# p consecutive_collapse([13, 11, 12, 12])              # []

def pretentious_primes(arr, n)
    arr.each.with_index do |ele, idx|
        arr[idx] = nearest_prime(ele, n)
    end
    return arr
end

def nearest_prime(ele, n)
    arr = []
    if n >= 0
        iterator = ele + 1
        until arr.length == n
            arr << iterator if is_prime?(iterator)
            iterator += 1
        end
        return arr[-1]
    else
        iterator = ele - 1
        until arr.length == n.abs
            return nil if iterator < 2
            arr << iterator if is_prime?(iterator)
            iterator -= 1
        end
        return arr[-1]
    end
end

# p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
# p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
# p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
# p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
# p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
# p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
# p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
# p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
# p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
# p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]
