# call  object.tests, n is the number of tests

class SuperScore
  def initialize
    @rows = []
  end

  def tests
    count = gets.chomp.to_i
    count.times do
      @rows << gets.chomp.split(' ')
    end
    calculate(count)
  end

  def calculate(count)
    output = []
    count.times do |i|
      output << @rows.max_by { |row| row[i] }[i].to_i
    end
    puts "#{output.join(',')} \n #{output.reduce(:+)}"
  end
end
