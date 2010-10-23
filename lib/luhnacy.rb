class Luhnacy
  @cards = {
    :mastercard => { :prefixes => [ '51', '52', '53', '54', '55' ], :size => 16 },
    :visa => { :prefixes => ['4'], :size => 16 },
    :amex => { :prefixes => ['34','37'], :size => 15 },
    :doctor_npi => { :prefixes => ['80840'], :size => 15 }
  }
  def self.valid?(candidate)
    calc_modulus(candidate) == 0
  end

  def self.generate(string_size, options={})
    raise ArgumentError, "prefix must be numeric" if options[:prefix] && !(options[:prefix] =~ /^\d*$/)

    output = options[:prefix] || ''
    (string_size-output.size-1).times do |n|
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

  def self.method_missing(type, *args)
    card_type, method_type = parse_method_name(type)
                                                  
    raise NoMethodError unless @cards[card_type] && @cards[card_type][:prefixes] && @cards[card_type][:size]

    send(method_type, *(args.unshift(card_type)))
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

  def self.parse_method_name(method_name) 
    method_name = method_name.to_s
    case method_name
    when /(.*)\?$/
      [ $~[1].to_sym, :valid_card? ]
    else 
      [ method_name.to_sym, :generate_card ]
    end
  end

  def self.valid_card?(card_type, card_number)
    valid?(card_number) && valid_pattern?(card_type, card_number)
  end

  def self.generate_card(card_type, options={})
      generate(@cards[card_type][:size], options.merge({:prefix => @cards[card_type][:prefixes][rand(@cards[card_type][:prefixes].size)]}))
  end

  def self.valid_pattern?(card_type, card_number)
    @cards[card_type][:prefixes].each do |prefix|
      return true if card_number =~ /^#{prefix}\d{#{@cards[card_type][:size] - prefix.size}}$/
    end
    false
  end
end
