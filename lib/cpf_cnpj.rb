require "cpf_cnpj/version"

# +CpfCnpj+ is a module that provides utility methods for dealing with CPFs and CNPJs.
#
# A CPF is a Brazilian federal ID number issued to natural persons, and a CNPJ is its counterpart
# for juridic persons (companies and the like).
#
# The module provides methods for differentiating a CPF from a CNPJ, formatting, and
# validating the numbers by verifying the check digits.
#
# *Important:* The methods in this module expect CPFs/CNPJs as strings, with only numbers.
# If the string is formatted, it's up to you to remove the punctuation.
#
# One way to do that is, for example:
# 	CpfCnpj.valid_cpf?(formatted_cpf.gsub(/\D/, ''))
module CpfCnpj
	# Checks the length of +cpf_or_cnpj+ to determine if it's a CPF or a CNPJ.
	#
	# 	CpfCnpj.type_of("12345678987") # 11 characters
	# 	# => :cpf
	# 	CpfCnpj.type_of("123456789876") # 12 characters
	# 	# => nil
	# 	CpfCnpj.type_of("01234567000198") # 14 characters
	# 	# => :cnpj
	# 	CpfCnpj.type_of(nil)
	# 	# => nil
	# 	CpfCnpj.type_of(12345678987)
	# 	# ArgumentError: argument must be a string or nil
 	def self.type_of(cpf_cnpj) # :arg: cpf_or_cnpj
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

	# Formats +cpf_or_cnpj+ as a CPF or a CNPJ.
	#
	# 	CpfCnpj.format("12345678987") # 11 characters (CPF)
	# 	# => "123.456.789-87"
	# 	CpfCnpj.format("123456789876") # 12 characters
	# 	# => "123456789876"
	# 	CpfCnpj.format("01234567000198") # 14 characters (CNPJ)
	# 	# => "01.234.567/0001-98"
	# 	CpfCnpj.format(nil)
	# 	# => nil
	# 	CpfCnpj.format(12345678987)
	# 	# ArgumentError: argument must be a string or nil
	def self.format(cpf_cnpj) # :arg: cpf_or_cnpj
		case type_of(cpf_cnpj)
		when :cpf
			"#{cpf_cnpj[0..2]}.#{cpf_cnpj[3..5]}.#{cpf_cnpj[6..8]}-#{cpf_cnpj[9..10]}"
		when :cnpj
			"#{cpf_cnpj[0..1]}.#{cpf_cnpj[2..4]}.#{cpf_cnpj[5..7]}/#{cpf_cnpj[8..11]}-#{cpf_cnpj[12..13]}"
		else
			cpf_cnpj
		end
	end

	# Validates +cpf+ as a CPF by verifying that the check digits match.
	#
	# 	CpfCnpj.valid_cpf?("12345678900") # invalid
	# 	# => false
	# 	CpfCnpj.valid_cpf?("11026822840") # valid
	# 	# => true
	# 	CpfCnpj.valid_cpf?("63871464000193") # valid CNPJ
	# 	# => false
	# 	CpfCnpj.valid_cpf?(nil)
	# 	# => false
	# 	CpfCnpj.valid_cpf?(11026822840)
	# 	# ArgumentError: argument must be a string or nil
	def self.valid_cpf?(cpf)
		return type_of(cpf) == :cpf && _mod11_check(cpf, 11)
	end

	# Validates +cnpj+ as a CNPJ by verifying that the check digits match.
	#
	# 	CpfCnpj.valid_cnpj?("12345678000100") # invalid
	# 	# => false
	# 	CpfCnpj.valid_cnpj?("63871464000193") # valid
	# 	# => true
	# 	CpfCnpj.valid_cnpj?("11026822840") # valid CPF
	# 	# => false
	# 	CpfCnpj.valid_cnpj?(nil)
	# 	# => false
	# 	CpfCnpj.valid_cnpj?(63871464000193)
	# 	# ArgumentError: argument must be a string or nil
	def self.valid_cnpj?(cnpj)
		return type_of(cnpj) == :cnpj && _mod11_check(cnpj, 9)
	end

	# Validates +cnpj_or_cnpj+ as either a CPF or a CNPJ by verifying that the check digits match.
	#
	# 	CpfCnpj.valid_cpf_cnpj?("12345678900") # invalid CPF
	# 	# => false
	# 	CpfCnpj.valid_cpf_cnpj?("12345678000100") # invalid CNPJ
	# 	# => false
	# 	CpfCnpj.valid_cpf_cnpj?("11026822840") # valid CPF
	# 	# => true
	# 	CpfCnpj.valid_cpf_cnpj?("63871464000193") # valid CNPJ
	# 	# => true
	# 	CpfCnpj.valid_cpf_cnpj?(nil)
	# 	# => false
	# 	CpfCnpj.valid_cpf_cnpj?(63871464000193)
	# 	# ArgumentError: argument must be a string or nil
	def self.valid_cpf_cnpj?(cpf_cnpj) # :arg: cpf_or_cnpj
		return valid_cpf?(cpf_cnpj) || valid_cnpj?(cpf_cnpj)
	end

	def self._mod11_check_digit(digits, mult_max) # :nodoc:
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

	def self._mod11_check(digits, mult_max) # :nodoc:
		_mod11_check_digit(digits[0..-2], mult_max) && _mod11_check_digit(digits, mult_max)
	end

	# ruby 1.8.7 doesn't have String#ord, and in versions after 1.8.7 String#[num] returns a
	# one-character string instead of the byte value of the character.
	# Since the return of this is always used to perform what is essentially an unclamped to_i
	# on the first character, do it right here.
	def self._int_value(str) # :nodoc:
		(str.respond_to?(:ord) ? str.ord : str[0]) - 48
	end
end
