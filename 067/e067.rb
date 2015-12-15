require 'httparty'

small_pyramid = [  [3],
                 [7, 4],
                [2, 4, 6],
               [8, 5, 9, 3] ]

get_start_time = Time.now
large_pyramid = HTTParty.get("https://projecteuler.net/project/resources/p067_triangle.txt").body.split(/\n/).map { |x| x.split.map(&:to_i) }
get_request_parse_time = Time.now - get_start_time

def solve(pyramid)
  very_last_row = pyramid.pop
  pyramid.reverse.inject(very_last_row) do |last_row, row|
    best_choices = last_row.each_cons(2).map(&:max)
    row.zip(best_choices).map { |x| x.inject(:+) }
  end[0]
end

solve_time = Time.now

puts "Solution: #{solve large_pyramid}"
puts "Time to GET from projecteuler.net and parse into array of ints: #{get_request_parse_time}" # 0.710213
puts "Actual soultion time:                                           #{Time.now - solve_time}"  # 0.010578
