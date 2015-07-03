require "cpf_cnpj/version"

module CpfCnpj
	def self.type_of(cpf_cnpj)
		return nil if cpf_cnpj.nil?
		unless cpf_cnpj.is_a?(String)
			raise(ArgumentError, "argument must be a string or nil")
		end
		case cpf_cnpj.length
		when 11 ; :cpf
		when 14 ; :cnpj
		else ; nil
		end
	end

	def self.format(cpf_cnpj)
		case type_of(cpf_cnpj)
		when :cpf
			"#{cpf_cnpj[0..2]}.#{cpf_cnpj[3..5]}.#{cpf_cnpj[6..8]}-#{cpf_cnpj[9..10]}"
		when :cnpj
			"#{cpf_cnpj[0..1]}.#{cpf_cnpj[2..4]}.#{cpf_cnpj[5..7]}/#{cpf_cnpj[8..11]}-#{cpf_cnpj[12..13]}"
		else
			cpf_cnpj
		end
	end

	def self.valid_cpf?(cpf)
		return type_of(cpf) == :cpf && _mod11_check(cpf, 11)
	end

	def self.valid_cnpj?(cnpj)
		return type_of(cnpj) == :cnpj && _mod11_check(cnpj, 9)
	end

	def self.valid_cpf_cnpj?(cpf_cnpj)
		return valid_cpf?(cpf_cnpj) || valid_cnpj?(cpf_cnpj)
	end

	def self._mod11_check_digit(digits, mult_max)
		sum = 0
		mult = 2
		digits[0..-2].reverse.each_char do |digit|
			digit = _int_value(digit)
			return false unless digit.between?(0, 9)
			sum += mult * digit
			mult += 1
			mult = 2 if mult > mult_max
		end
		sum = 11 - (sum % 11)
		sum = 0 if sum > 9
		_int_value(digits[-1]) == sum
	end

	def self._mod11_check(digits, mult_max)
		_mod11_check_digit(digits[0..-2], mult_max) && _mod11_check_digit(digits, mult_max)
	end

	# ruby 1.8.7 doesn't have String#ord, and in versions after 1.8.7 String#[num] returns a
	# one-character string instead of the byte value of the character.
	# Since the return of this is always used to perform what is essentially an unclamped to_i
	# on the first character, do it right here.
	def self._int_value(str)
		(str.respond_to?(:ord) ? str.ord : str[0]) - 48
	end
end
