class Luhnacy
  def self.valid?(candidate)
    calc_modulus(candidate) == 0
  end

  def self.generate(string_size, options={})
    output = options[:prefix] || ''
    (string_size-1).times do |n|
      output += rand(10).to_s
    end
    output += '0'

    if options[:invalid]
      case calc_modulus(output)
      when 0
        output = output[0...-1] + (rand(8) + 1).to_s
      when [1..8]
        output = output[0...-1] + ((10 - calc_modulus(output))/2).to_s
      when 9
        output = output[0...-1] + (rand(7) + 2).to_s
      end
    else
      unless calc_modulus(output) == 0
        output = output[0...-1] + (10 - calc_modulus(output)).to_s
      end
    end

    output
  end

  private
  def self.double_and_fix(number)
    2 * number > 9 ? ( (2 * number) % 10 + 1 ) : 2 * number
  end

  def self.calc_modulus(candidate)
    working = candidate.reverse
    double_up = false;
    sum = 0

    working.each_char do |ch|
      num = ch.to_i
      sum += double_up ? double_and_fix(num) : num
      double_up = !double_up
    end

    sum % 10
  end
end
