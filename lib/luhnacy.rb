class Luhnacy
  def self.valid?(candidate)
    working = candidate.reverse
    double_up = false;
    sum = 0

    working.each_char do |ch|
      num = ch.to_i
      sum += double_up ? double_and_fix(num) : num
      double_up = !double_up
    end
    sum % 10 == 0
  end
  def self.generate(string_size)
    return "11111"
  end

  private
  def self.double_and_fix(number)
    2 * number > 9 ? ( (2 * number) % 10 + 1 ) : 2 * number
  end
end
