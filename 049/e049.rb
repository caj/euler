require 'prime'
require 'set'

def primes_4_digits
  ret = []
  Prime.each do |p|
    break if p/10000 >= 1
    ret.push p if p/1000 >= 1
  end
  ret
end

def num_2_digits n, acc = []
  if n == 0
    return acc.reverse
  end
  num_2_digits(n/10, acc + [n%10])
end

def digits_2_num arr
  arr.inject(0) { |acc, x| acc*10 + x}
end

def arithmetic_seq? arr
  rate = nil
  arr.each_with_index do |x, i|
    rate = arr[i+1] - x unless rate
    next_num = arr[i+1] ? arr[i+1] : x + rate
    new_rate = next_num - x
    #puts "X: #{x}\nRATE: #{rate}\nNEW RATE: #{new_rate}\n----------\n"
    return false unless rate == new_rate
  end
  true
end

def e049
  p4d = primes_4_digits
  sets = Set.new
  p4d.dup.each do |p|
    n2dp = num_2_digits(p).sort
    set = p4d.select { |x| num_2_digits(x).sort == n2dp }
    set = set.permutation(3).map(&:sort).uniq.select { |x| arithmetic_seq? x }
    sets.add set
  end
  sets.reject { |x| x.empty? }.flatten(1).find { |x| x.first != 1487 }.inject('') { |acc, x| acc + x.to_s }
end

puts e049
